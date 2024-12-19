import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/data/providers/data_storage_provider.dart';
import 'package:eeg_app/domain/use_cases/share_file_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'share_file_use_case.g.dart';

/// Represents a use case for sharing a file.
@riverpod
UseCase<Unit, Params> shareFileUseCase(Ref ref) {
  final dataStorageRepo = ref.read(dataStorageRepoProvider);
  return ShareFileUseCase(dataStorageRepo);
}
