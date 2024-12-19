import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/entities/file_info.dart';
import 'package:eeg_app/domain/providers/delete_file_use_case.dart';
import 'package:eeg_app/domain/providers/get_files_info_use_case.dart';
import 'package:eeg_app/domain/use_cases/delete_file_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'files_info.g.dart';

/// Notifier for files info
@riverpod
class FilesInfoNotifier extends _$FilesInfoNotifier {
  @override
  Future<List<FileInfo>> build() async {
    final getFilesInfoUseCase = ref.read(getFilesInfoUseCaseProvider);
    final filesInfo = await getFilesInfoUseCase(NoParams());
    return filesInfo.fold(
      (failure) {
        throw Exception(failure.message);
      },
      (data) {
        return data;
      },
    );
  }

  /// Delete file info
  Future<Either<Failure, Unit>> deleteFileInfo(FileInfo fileInfo) async {
    final deleteFileUseCase = ref.read(deleteFileProvider);
    final params = Params(fileInfo);
    final result = await deleteFileUseCase(params);
    return await result.fold(
      (failure) {
        return Left(failure);
      },
      (data) async {
        final getFilesInfoUseCase = ref.read(getFilesInfoUseCaseProvider);
        final filesInfo = await getFilesInfoUseCase(NoParams());
        filesInfo.fold(
          (failure) {
            state = AsyncError(failure.message, failure.stackTrace);
          },
          (data) {
            state = AsyncData(data);
          },
        );
        return const Right(unit);
      },
    );
  }
}
