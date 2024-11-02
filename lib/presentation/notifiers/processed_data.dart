import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/providers/get_processed_data_stream_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'processed_data.g.dart';

/// Notifier to store the processed data
@riverpod
class ProcessedDataNotifier extends _$ProcessedDataNotifier {
  @override
  Future<List<List<double>>> build() {
    return Future.value(List.generate(4, (i) => []));
  }

  /// Start listening for data
  Future<void> startListeningForData() async {
    final getProcessedDataStreamUseCase =
        ref.read(getProcessedDataStreamUseCaseProvider);
    final result = await getProcessedDataStreamUseCase(NoParams());

    result.fold(
      (failure) {
        state = AsyncError(failure, failure.stackTrace);
      },
      (dataStream) {
        dataStream.listen(
          (data) {
            state = AsyncData(data);
          },
        );
      },
    );
  }
}
