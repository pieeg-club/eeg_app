import 'package:eeg_app/presentation/notifiers/processed_data.dart';
import 'package:eeg_app/presentation/widgets/charts/chart.dart';
import 'package:eeg_app/presentation/widgets/connection_button.dart';
import 'package:eeg_app/presentation/widgets/files_info_dialog.dart';
import 'package:eeg_app/presentation/widgets/recording_button.dart';
import 'package:eeg_app/presentation/widgets/settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Main page of the app
class MainPage extends ConsumerWidget {
  /// Default constructor
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final processedData = ref.watch(processedDataNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EEG App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) {
                            return const FilesInfoDialog();
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.folder,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) {
                            return SettingsDialog();
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.settings,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ConnectionButton(),
                    RecordingButton(),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Charts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
      ),
    );
  }
}
