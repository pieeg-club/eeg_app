import 'package:eeg_app/domain/entities/settings.dart';
import 'package:eeg_app/presentation/notifiers/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dialog for settings
class SettingsDialog extends ConsumerWidget {
  /// Default constructor
  SettingsDialog({super.key});

  final _bandPassHighCutOffController = TextEditingController();
  final _bandPassLowCutOffController = TextEditingController();
  final _numberOfChannelsController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);
    final settingsNotifier = ref.read(settingsNotifierProvider.notifier);
    return settings.when(
      data: (data) {
        _bandPassHighCutOffController.text = data.bandPassHighCutOff.toString();
        _bandPassLowCutOffController.text = data.bandPassLowCutOff.toString();
        _numberOfChannelsController.text = data.numberOfChannels.toString();
        return AlertDialog(
          title: const Text('Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _bandPassHighCutOffController,
                decoration: const InputDecoration(
                  labelText: 'Band Pass High Cut Off',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _bandPassLowCutOffController,
                decoration: const InputDecoration(
                  labelText: 'Band Pass Low Cut Off',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _numberOfChannelsController,
                decoration: const InputDecoration(
                  labelText: 'Number of Channels',
                ),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<AlgorithmType>(
                value: data.algorithmType,
                decoration: const InputDecoration(
                  labelText: 'Algorithm Type',
                ),
                items: AlgorithmType.values.map((type) {
                  return DropdownMenuItem<AlgorithmType>(
                    value: type,
                    child: Text(
                      _convertIntoUserFriendlyString(type),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  final newSettings = data.copyWith(
                    bandPassHighCutOff:
                        double.tryParse(_bandPassHighCutOffController.text),
                    bandPassLowCutOff:
                        double.tryParse(_bandPassLowCutOffController.text),
                    numberOfChannels:
                        int.tryParse(_numberOfChannelsController.text),
                    algorithmType: newValue,
                  );
                  settingsNotifier.updateSettings(newSettings);
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final newSettings = data.copyWith(
                  bandPassHighCutOff:
                      double.tryParse(_bandPassHighCutOffController.text),
                  bandPassLowCutOff:
                      double.tryParse(_bandPassLowCutOffController.text),
                  numberOfChannels:
                      int.tryParse(_numberOfChannelsController.text),
                );
                final result = await settingsNotifier.saveSettings(newSettings);
                result.fold(
                  (failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(failure.message),
                      ),
                    );
                  },
                  (_) {
                    Navigator.of(context).pop();
                  },
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
      error: (e, s) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
        );
      },
      loading: () {
        return const AlertDialog(
          title: Text('Loading'),
          content: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  String _convertIntoUserFriendlyString(AlgorithmType type) {
    switch (type) {
      case AlgorithmType.bandPass:
        return 'Band Pass';
    }
  }
}
