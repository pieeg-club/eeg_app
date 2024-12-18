import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/entities/file_info.dart';
import 'package:eeg_app/domain/repositories/data_storage_repo.dart';

/// A UseCase that deletes a file from the storage
class DeleteFileUseCase implements UseCase<Unit, Params> {
  /// Constructor
  DeleteFileUseCase(this._dataStorageRepo);

  final DataStorageRepo _dataStorageRepo;

  @override
  Future<Either<Failure, Unit>> call(Params params) {
    return _dataStorageRepo.deleteFile(params.fileInfo.name);
  }
}

/// Params for the [DeleteFileUseCase]
class Params {
  /// Constructor
  Params(this.fileInfo);

  /// The [FileInfo] to delete
  final FileInfo fileInfo;
}
