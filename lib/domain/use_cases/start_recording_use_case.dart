import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/repositories/data_storage_repo.dart';

/// Represents a use case for starting the recording.
class StartRecordingUseCase implements UseCase<Unit, NoParams> {
  /// Constructs a [StartRecordingUseCase] with the given [DataStorageRepo].
  const StartRecordingUseCase(this._dataStorageRepo);

  final DataStorageRepo _dataStorageRepo;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return _dataStorageRepo.startRecording();
  }
}
