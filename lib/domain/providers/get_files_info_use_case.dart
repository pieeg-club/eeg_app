import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/data/providers/data_storage_provider.dart';
import 'package:eeg_app/domain/entities/file_info.dart';
import 'package:eeg_app/domain/use_cases/get_files_info_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_files_info_use_case.g.dart';

@riverpod
UseCase<List<FileInfo>, NoParams> getFilesInfoUseCase(Ref ref) {
  final dataStorageRepo = ref.read(dataStorageRepoProvider);
  return GetFilesInfoUseCase(dataStorageRepo);
}
