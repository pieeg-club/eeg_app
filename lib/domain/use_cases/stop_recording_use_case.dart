import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/repositories/data_storage_repo.dart';

/// A use case that stops the recording.
class StopRecordingUseCase implements UseCase<Unit, NoParams> {
  /// Constructs a [StopRecordingUseCase] with the given [DataStorageRepo].
  const StopRecordingUseCase(this._dataStorageRepo);

  final DataStorageRepo _dataStorageRepo;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return _dataStorageRepo.stopRecording();
  }
}
