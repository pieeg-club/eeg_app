import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/providers/is_recording_use_case.dart';
import 'package:eeg_app/domain/providers/start_recording_use_case.dart';
import 'package:eeg_app/domain/providers/stop_recording_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recording.g.dart';

/// Notifier for recording
@riverpod
class RecordingNotifier extends _$RecordingNotifier {
  @override
  Future<bool> build() async {
    final isRecordingUseCase = ref.read(isRecordingUseCaseProvider);
    final isRecording = await isRecordingUseCase(NoParams());
    return isRecording.fold(
      (failure) => throw Exception(failure.message),
      (isRecording) => isRecording,
    );
  }

  /// Start recording
  Future<Either<Failure, Unit>> startRecording() async {
    final startRecordingUseCase = ref.read(startRecordingUseCaseProvider);
    final result = await startRecordingUseCase(NoParams());
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (data) async {
        final isRecordingUseCase = ref.read(isRecordingUseCaseProvider);
        final isRecording = await isRecordingUseCase(NoParams());
        isRecording.fold(
          (failure) {
            state = AsyncError(failure.message, failure.stackTrace);
          },
          (isRecording) {
            state = AsyncData(isRecording);
          },
        );
        return const Right(unit);
      },
    );
  }

  /// Stop recording
  Future<Either<Failure, Unit>> stopRecording() async {
    final stopRecordingUseCase = ref.read(stopRecordingUseCaseProvider);
    final result = await stopRecordingUseCase(NoParams());
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (data) async {
        final isRecordingUseCase = ref.read(isRecordingUseCaseProvider);
        final isRecording = await isRecordingUseCase(NoParams());
        isRecording.fold(
          (failure) {
            state = AsyncError(failure.message, failure.stackTrace);
          },
          (isRecording) {
            state = AsyncData(isRecording);
          },
        );
        return const Right(unit);
      },
    );
  }
}
