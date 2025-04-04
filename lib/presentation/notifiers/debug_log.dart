import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/providers/get_logs_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_log.g.dart';

/// Notifier for debug log
@riverpod
class DebugLog extends _$DebugLog {
  @override
  Future<List<String>> build() async {
    final getDebugLogUseCase = ref.read(getLogsUseCaseProvider);
    final logs = await getDebugLogUseCase(NoParams());
    return logs.fold(
      (failure) {
        throw Exception(failure.message);
      },
      (data) {
        return data;
      },
    );
  }

  /// Refresh debug log
  Future<void> refresh() async {
    state = const AsyncLoading();
    final getDebugLogUseCase = ref.read(getLogsUseCaseProvider);
    final logs = await getDebugLogUseCase(NoParams());
    logs.fold(
      (failure) {
        state = AsyncError(failure.message, failure.stackTrace);
      },
      (data) {
        state = AsyncData(data);
      },
    );
  }
}
