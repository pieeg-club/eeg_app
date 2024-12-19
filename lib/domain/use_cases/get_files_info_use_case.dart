import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/entities/file_info.dart';
import 'package:eeg_app/domain/repositories/data_storage_repo.dart';

/// A UseCase that gets the list of files info from the storage
class GetFilesInfoUseCase implements UseCase<List<FileInfo>, NoParams> {
  /// Constructor
  GetFilesInfoUseCase(this._dataStorageRepo);

  final DataStorageRepo _dataStorageRepo;

  @override
  Future<Either<Failure, List<FileInfo>>> call(NoParams params) {
    return _dataStorageRepo.getFilesInfo();
  }
}
