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
    return Future.value(
      dataStreamResult.fold(
        (failure) => const Right(
          Stream<Either<Failure, AlgorithmResult>>.empty(),
        ),
        (dataStream) => Right(_algorithm(dataStream)),
      ),
    );
  }
}
