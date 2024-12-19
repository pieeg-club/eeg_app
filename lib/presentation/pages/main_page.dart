import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/providers/connect_use_case.dart';
import 'package:eeg_app/domain/providers/disconnect_use_case.dart';
import 'package:eeg_app/domain/providers/start_recording_use_case.dart';
import 'package:eeg_app/domain/providers/stop_recording_use_case.dart';
import 'package:eeg_app/presentation/notifiers/processed_data.dart';
import 'package:eeg_app/presentation/widgets/charts/chart.dart';
import 'package:eeg_app/presentation/widgets/files_info_dialog.dart';
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
    final startRecordingUseCase = ref.read(startRecordingUseCaseProvider);
    final stopRecordingUseCase = ref.read(stopRecordingUseCaseProvider);
    final processedData = ref.watch(processedDataNotifierProvider);
    final processedDataNotifier =
        ref.read(processedDataNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('EEG App'),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                          content:
                              Text('Successfully connected to the device!'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final result = await startRecordingUseCase(NoParams());
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
                    },
                    child: const Text('Start Recording'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await stopRecordingUseCase(NoParams());
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
                    },
                    child: const Text('Stop Recording'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return const FilesInfoDialog();
                    },
                  );
                },
                child: const Text('Files Info'),
              ),
              const SizedBox(height: 20),
              const Text('Charts:'),
              const SizedBox(height: 20),
              processedData.when(
                data: (data) {
                  return Chart(
                    data: data,
                  );
                },
                error: (error, stackTrace) => Text('Error: $error'),
                loading: () => const CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
