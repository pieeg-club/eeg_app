import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/providers/is_connected_use_case.dart';
import 'package:eeg_app/domain/providers/start_recording_use_case.dart';
import 'package:eeg_app/domain/providers/stop_recording_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connection.g.dart';

/// Notifier for connection
@riverpod
class ConnectionNotifier extends _$ConnectionNotifier {
  @override
  Future<bool> build() async {
    final isConnectedUseCase = ref.read(isConnectedUseCaseProvider);
    final isConnected = await isConnectedUseCase(NoParams());
    return isConnected.fold(
      (failure) => throw Exception(failure.message),
      (isConnected) => isConnected,
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
        final isConnectedUseCase = ref.read(isConnectedUseCaseProvider);
        final isConnected = await isConnectedUseCase(NoParams());
        isConnected.fold(
          (failure) {
            state = AsyncError(failure.message, failure.stackTrace);
          },
          (isConnected) {
            state = AsyncData(isConnected);
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
        final isConnectedUseCase = ref.read(isConnectedUseCaseProvider);
        final isConnected = await isConnectedUseCase(NoParams());
        isConnected.fold(
          (failure) {
            state = AsyncError(failure.message, failure.stackTrace);
          },
          (isConnected) {
            state = AsyncData(isConnected);
          },
        );
        return const Right(unit);
      },
    );
  }
}
