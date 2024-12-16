import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/entities/algorithm_results/algorithm_result.dart';
import 'package:eeg_app/domain/entities/algorithm_results/band_pass_algorithm_result.dart';
import 'package:eeg_app/domain/providers/get_processed_data_stream_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'processed_data.g.dart';

/// Notifier to store the processed data
@riverpod
class ProcessedDataNotifier extends _$ProcessedDataNotifier {
  @override
  Future<AlgorithmResult> build() async {
    return BandPassAlgorithmResult([]);
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
            data.fold(
              (failure) {
                state = AsyncError(failure, failure.stackTrace);
              },
              (data) {
                state = AsyncData(data);
              },
            );
          },
        );
      },
    );
  }
}
