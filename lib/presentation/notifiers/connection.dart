import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/providers/connect_use_case.dart';
import 'package:eeg_app/domain/providers/disconnect_use_case.dart';
import 'package:eeg_app/domain/providers/is_connected_use_case.dart';
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

  /// Connect to the device
  Future<Either<Failure, Unit>> connect() async {
    final connectUseCase = ref.read(connectUseCaseProvider);
    final result = await connectUseCase(NoParams());
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

  /// Disconnect from the device
  Future<Either<Failure, Unit>> disconnect() async {
    final disconnectUseCase = ref.read(disconnectUseCaseProvider);
    final result = await disconnectUseCase(NoParams());
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
