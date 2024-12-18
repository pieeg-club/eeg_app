import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/data/providers/data_storage_provider.dart';
import 'package:eeg_app/domain/use_cases/delete_file_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_file_use_case.g.dart';

/// A provider that creates a use case to delete a file.
@riverpod
UseCase<Unit, Params> deleteFile(Ref ref) {
  final dataStorageRepo = ref.read(dataStorageRepoProvider);
  return DeleteFileUseCase(dataStorageRepo);
}
