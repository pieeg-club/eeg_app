import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/data/providers/data_storage_provider.dart';
import 'package:eeg_app/domain/use_cases/stop_recording_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stop_recording_use_case.g.dart';

/// A provider that creates a use case that stops the recording.
@riverpod
UseCase<Unit, NoParams> stopRecordingUseCase(Ref ref) {
  final dataStorageRepo = ref.read(dataStorageRepoProvider);
  return StopRecordingUseCase(dataStorageRepo);
}
