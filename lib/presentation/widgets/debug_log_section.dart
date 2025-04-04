import 'package:eeg_app/presentation/notifiers/debug_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that displays debug logs in an expandable section.
class DebugLogSection extends ConsumerWidget {
  /// Creates a [DebugLogSection].
  const DebugLogSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debugLog = ref.watch(debugLogProvider);
    final debugLogNotifier = ref.read(debugLogProvider.notifier);

    return ExpansionTile(
      title: const Text('Debug Logs'),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: debugLogNotifier.refresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
          ],
        ),
        debugLog.when(
          data: (logs) => SizedBox(
            height: 150,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: logs.length,
              itemBuilder: (_, i) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Text(logs[i]),
              ),
            ),
          ),
          loading: () => const Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(),
          ),
          error: (e, _) => Padding(
            padding: const EdgeInsets.all(8),
            child: Text('Error loading logs: $e'),
          ),
        ),
      ],
    );
  }
}
