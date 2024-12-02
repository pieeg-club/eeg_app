import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/providers/connect_use_case.dart';
import 'package:eeg_app/domain/providers/disconnect_use_case.dart';
import 'package:eeg_app/presentation/notifiers/processed_data.dart';
import 'package:eeg_app/presentation/widgets/settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Main page of the app
class MainPage extends ConsumerWidget {
  /// Default constructor
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectDeviceUseCase = ref.read(connectUseCaseProvider);
    final disconnectDeviceUseCase = ref.read(disconnectUseCaseProvider);
    final processedData = ref.watch(processedDataNotifierProvider);
    final processedDataNotifier =
        ref.read(processedDataNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('EEG App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final result = await connectDeviceUseCase(NoParams());
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
              },
              child: const Text('Connect'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await disconnectDeviceUseCase(NoParams());
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
              },
              child: const Text('Disconnect'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (context) {
                    return SettingsDialog();
                  },
                );
              },
              child: const Text('Settings'),
            ),
            const SizedBox(height: 20),
            processedData.when(
              data: (data) {
                return Column(
                  children: List.generate(
                    data.length,
                    (i) => Text('Channel $i: ${data[i]}'),
                  ),
                );
              },
              error: (error, stackTrace) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
