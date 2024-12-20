import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/repositories/data_storage_repo.dart';

/// Use case to check if the recording is currently in progress
class IsRecordingUseCase implements UseCase<bool, NoParams> {
  /// Constructor for the use case
  IsRecordingUseCase(this._dataStorageRepo);

  final DataStorageRepo _dataStorageRepo;

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return _dataStorageRepo.isRecording();
  }
}
