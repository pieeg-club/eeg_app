import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/entities/file_info.dart';
import 'package:eeg_app/domain/repositories/data_storage_repo.dart';

/// A use case for sharing a file.
class ShareFileUseCase implements UseCase<Unit, Params> {
  /// Creates the [ShareFileUseCase].
  ShareFileUseCase(this._dataStorageRepo);

  final DataStorageRepo _dataStorageRepo;

  @override
  Future<Either<Failure, Unit>> call(Params params) {
    return _dataStorageRepo.shareFile(params.fileInfo.path);
  }
}

/// Parameters for the [ShareFileUseCase].
class Params {
  /// Creates the [Params].
  Params(this.fileInfo);

  /// The file info to share.
  final FileInfo fileInfo;
}
