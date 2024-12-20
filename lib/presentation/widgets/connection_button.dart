import 'package:eeg_app/presentation/notifiers/connection.dart';
import 'package:eeg_app/presentation/notifiers/processed_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Connection button widget
class ConnectionButton extends ConsumerWidget {
  /// Default constructor
  const ConnectionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnected = ref.watch(connectionNotifierProvider);
    final connectionNotifier = ref.read(connectionNotifierProvider.notifier);
    final processedDataNotifier =
        ref.read(processedDataNotifierProvider.notifier);
    return isConnected.when(
      error: (error, s) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (isConnected) {
        return ElevatedButton.icon(
          onPressed: isConnected
              ? () async => _disconnectAction(
                    context,
                    connectionNotifier,
                  )
              : () async => _connectAction(
                    context,
                    connectionNotifier,
                    processedDataNotifier,
                  ),
          icon: Icon(
            isConnected ? Icons.bluetooth_disabled : Icons.bluetooth,
          ),
          label: Text(isConnected ? 'Disconnect' : 'Connect'),
        );
      },
    );
  }

  Future<void> _connectAction(
    BuildContext context,
    ConnectionNotifier connectionNotifier,
    ProcessedDataNotifier processedDataNotifier,
  ) async {
    final result = await connectionNotifier.connect();
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
            content: Text('Successfully connected to the device!'),
            duration: Duration(
              seconds: 2,
            ),
          ),
        );
        processedDataNotifier.startListeningForData();
      },
    );
  }

  Future<void> _disconnectAction(
    BuildContext context,
    ConnectionNotifier connectionNotifier,
  ) async {
    final result = await connectionNotifier.disconnect();
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
            content: Text('Successfully disconnected!'),
            duration: Duration(
              seconds: 2,
            ),
          ),
        );
      },
    );
  }
}
