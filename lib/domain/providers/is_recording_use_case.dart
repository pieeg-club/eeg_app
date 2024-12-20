import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/data/providers/data_storage_provider.dart';
import 'package:eeg_app/domain/use_cases/is_recording_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_recording_use_case.g.dart';

/// Provider to create an instance of [UseCase] to check
/// if the recording is in progress.
@riverpod
UseCase<bool, void> isRecordingUseCase(Ref ref) {
  final dataStorageRepo = ref.read(dataStorageRepoProvider);
  return IsRecordingUseCase(dataStorageRepo);
}
