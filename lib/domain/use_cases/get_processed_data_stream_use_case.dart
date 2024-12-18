import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/algorithms/algorithm.dart';
import 'package:eeg_app/domain/entities/algorithm_results/algorithm_result.dart';
import 'package:eeg_app/domain/repositories/device_repo.dart';

/// A use case that gets a stream of processed data.
class GetProcessedDataStreamUseCase
    implements UseCase<Stream<Either<Failure, AlgorithmResult>>, NoParams> {
  /// Constructs a [GetProcessedDataStreamUseCase] with the given [DeviceRepo].
  GetProcessedDataStreamUseCase(this._deviceRepo, this._algorithm);

  final DeviceRepo _deviceRepo;
  final Algorithm _algorithm;

  @override
  Future<Either<Failure, Stream<Either<Failure, AlgorithmResult>>>> call(
    NoParams params,
  ) async {
    // Get the data stream result from the repository
    final dataStreamResult = await _deviceRepo.getDataStream();

    // Handle the Either result
    return dataStreamResult.fold(
      (failure) => const Right(
        Stream<Either<Failure, AlgorithmResult>>.empty(),
      ),
      (dataStream) => Right(_processDataStream(dataStream)),
    );
  }

  Stream<Either<Failure, AlgorithmResult>> _processDataStream(
    Stream<List<int>> dataStream,
  ) async* {
    await for (final rawData in dataStream) {
      final eitherResult = await _algorithm(rawData);

      // Using `yield*` here allows the folded streams to produce
      // zero or one values.
      // For example, if `_algorithm(rawData)` returns an Option.none(),
      // we won't yield anything.

      // Use fold on the Either
      yield* eitherResult.fold(
        (failure) async* {
          // If it's Left, we have a Failure directly
          yield Left<Failure, AlgorithmResult>(failure);
        },
        (optionResult) async* {
          // If it's Right(Option), fold over the Option
          yield* optionResult.fold(
            () async* {
              // None case: do nothing and continue
            },
            (value) async* {
              // Some case: yield the AlgorithmResult
              yield Right<Failure, AlgorithmResult>(value);
            },
          );
        },
      );
    }
  }
}
