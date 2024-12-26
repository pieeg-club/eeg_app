import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/failures/processing_step_failures.dart';
import 'package:eeg_app/domain/repositories/processing_step_repo.dart';
import 'package:eeg_app/domain/repositories/settings_repo.dart';
import 'package:synchronized/synchronized.dart';

/// Splits the input data into multiple channels
class SplitIntoChannelsStep
    implements ProcessingStepRepo<List<List<int>>, List<int>> {
  /// Constructor for the split into channels step
  SplitIntoChannelsStep(this._settings) {
    _initializeSplitIntoChannels();
  }

  final SettingsRepo _settings;
  late int _numberOfChannels;
  final _lock = Lock();

  @override
  Future<Either<ProcessingStepFailure, List<List<int>>>> call(
    List<int> input, {
    int bytesPerSample = 3,
  }) async {
    try {
      return _lock.synchronized(() async {
        final channelData = List.generate(
          _numberOfChannels,
          (_) => <int>[],
          growable: false,
        );

        for (var sample = 0;
            sample < (input.length / bytesPerSample);
            sample++) {
          final channel = sample % _numberOfChannels;
          channelData[channel].addAll(
            input.sublist(
              sample * bytesPerSample,
              (sample + 1) * bytesPerSample,
            ),
          );
        }

        return Right(channelData);
      });
    } catch (e, s) {
      log('Error splitting into channels: $e, $s');
      return Left(
        ProcessingStepFailure.wrongNumberOfChannels(s),
      );
    }
  }

  Future<void> _initializeSplitIntoChannels() async {
    // Fetch initial settings
    final initialSettings = await _settings.getSettings();
    await _lock.synchronized(() {
      _numberOfChannels = initialSettings.numberOfChannels;
    });

    // Listen for settings updates and update local variables
    _settings.getSettingsStream().listen((settings) async {
      await _lock.synchronized(() {
        _numberOfChannels = settings.numberOfChannels;
      });
    });
  }
}
