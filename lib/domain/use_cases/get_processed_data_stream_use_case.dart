import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/algorithms/algorithm.dart';
import 'package:eeg_app/domain/entities/algorithm_results/algorithm_result.dart';
import 'package:eeg_app/domain/entities/settings.dart';
import 'package:eeg_app/domain/repositories/data_storage_repo.dart';
import 'package:eeg_app/domain/repositories/device_repo.dart';
import 'package:eeg_app/domain/repositories/settings_repo.dart';
import 'package:synchronized/synchronized.dart';

/// A use case that gets a stream of processed data.
class GetProcessedDataStreamUseCase
    implements UseCase<Stream<Either<Failure, AlgorithmResult>>, NoParams> {
  /// Constructor for the use case.
  GetProcessedDataStreamUseCase(
    this._deviceRepo,
    this._dataStorageRepo,
    this._settingsRepo,
    this._bandPassAlgorithm,
  ) {
    _initializeUseCase();
  }

  late Algorithm _algorithm;
  final Algorithm _bandPassAlgorithm;
  final DeviceRepo _deviceRepo;
  final DataStorageRepo _dataStorageRepo;
  final SettingsRepo _settingsRepo;
  final _lock = Lock();

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
      await _dataStorageRepo.saveData(rawData.toString());
      Either<Failure, Option<AlgorithmResult>>? eitherResult;
      await _lock.synchronized(() async {
        eitherResult = await _algorithm(rawData);
      });
      if (eitherResult == null) {
        continue;
      }

      // Using `yield*` here allows the folded streams to produce
      // zero or one values.
      // For example, if `_algorithm(rawData)` returns an Option.none(),
      // we won't yield anything.

      // Use fold on the Either
      yield* eitherResult!.fold(
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

  Future<void> _initializeUseCase() async {
    // Fetch initial settings
    final initialSettings = await _settingsRepo.getSettings();
    await _lock.synchronized(() {
      _algorithm = _getAlgorithm(initialSettings.algorithmType);
    });

    // Listen for settings updates and update local variables
    _settingsRepo.getSettingsStream().listen((settings) async {
      await _lock.synchronized(() {
        _algorithm = _getAlgorithm(settings.algorithmType);
      });
    });
  }

  Algorithm _getAlgorithm(AlgorithmType type) {
    switch (type) {
      case AlgorithmType.bandPass:
        return _bandPassAlgorithm;
    }
  }
}
