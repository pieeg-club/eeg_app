import 'package:eeg_app/presentation/notifiers/recording.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Recording button widget
class RecordingButton extends ConsumerWidget {
  /// Default constructor
  const RecordingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecording = ref.watch(recordingNotifierProvider);
    final recordingNotifier = ref.read(recordingNotifierProvider.notifier);
    return isRecording.when(
      error: (error, s) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (isRecording) {
        return ElevatedButton.icon(
          onPressed: isRecording
              ? () async => _stopRecordingAction(
                    context,
                    recordingNotifier,
                  )
              : () async => _startRecordingAction(
                    context,
                    recordingNotifier,
                  ),
          icon: isRecording
              ? const Icon(Icons.stop)
              : const Icon(Icons.fiber_manual_record),
          label: SizedBox(
            width: 75,
            height: 60,
            child: Center(
              child: isRecording
                  ? const Text('Stop recording')
                  : const Text('Start recording'),
            ),
          ),
        );
      },
    );
  }

  Future<void> _startRecordingAction(
    BuildContext context,
    RecordingNotifier recordingNotifier,
  ) async {
    final result = await recordingNotifier.startRecording();
    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
          ),
        );
      },
      (data) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recording started!'),
            duration: Duration(
              seconds: 2,
            ),
          ),
        );
      },
    );
  }

  Future<void> _stopRecordingAction(
    BuildContext context,
    RecordingNotifier recordingNotifier,
  ) async {
    final result = await recordingNotifier.stopRecording();
    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
          ),
        );
      },
      (data) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recording stopped!'),
            duration: Duration(
              seconds: 2,
            ),
          ),
        );
      },
    );
  }
}
