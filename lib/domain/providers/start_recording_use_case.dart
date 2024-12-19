import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/data/providers/data_storage_provider.dart';
import 'package:eeg_app/domain/use_cases/start_recording_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'start_recording_use_case.g.dart';

/// Use case for starting recording
@riverpod
UseCase<Unit, NoParams> startRecordingUseCase(Ref ref) {
  final dataStorageRepo = ref.read(dataStorageRepoProvider);
  return StartRecordingUseCase(dataStorageRepo);
}
