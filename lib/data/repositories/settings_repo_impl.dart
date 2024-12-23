import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/entities/settings.dart';
import 'package:eeg_app/domain/failures/settings_failures.dart';
import 'package:eeg_app/domain/repositories/settings_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of the settings repository
class SettingsRepoImpl implements SettingsRepo {
  /// Constructor for [SettingsRepoImpl]
  SettingsRepoImpl() : _asyncPrefs = SharedPreferencesAsync();
  final SharedPreferencesAsync _asyncPrefs;
  final _settingsController = StreamController<Settings>.broadcast();

  @override
  Future<Settings> getSettings() async {
    try {
      final bandPassHighCutOff = await _asyncPrefs.getDouble(
        SettingsList.bandPassHighCutOff.name,
      );
      final bandPassLowCutOff = await _asyncPrefs.getDouble(
        SettingsList.bandPassLowCutOff.name,
      );
      final numberOfChannels = await _asyncPrefs.getInt(
        SettingsList.numberOfChannels.name,
      );
      return Settings(
        bandPassHighCutOff: bandPassHighCutOff!,
        bandPassLowCutOff: bandPassLowCutOff!,
        numberOfChannels: numberOfChannels!,
      );
    } catch (e) {
      return Settings.defaultSettings();
    }
  }

  @override
  Future<Either<SettingsFailures, Unit>> saveSettings(Settings settings) async {
    try {
      if (settings.bandPassLowCutOff < 0 ||
          settings.bandPassHighCutOff < settings.bandPassLowCutOff) {
        return left(
          SettingsFailures.incorrectBandPassCutOffs(StackTrace.current),
        );
      }
      await _asyncPrefs.setDouble(
        SettingsList.bandPassHighCutOff.name,
        settings.bandPassHighCutOff,
      );
      await _asyncPrefs.setDouble(
        SettingsList.bandPassLowCutOff.name,
        settings.bandPassLowCutOff,
      );

      await _asyncPrefs.setInt(
        SettingsList.numberOfChannels.name,
        settings.numberOfChannels,
      );

      _settingsController.add(settings);

      return right(unit);
    } catch (e, s) {
      log('Failed to save settings', error: e, stackTrace: s);
      return left(SettingsFailures.unknown(s));
    }
  }

  @override
  Stream<Settings> getSettingsStream() async* {
    yield await getSettings();
    yield* _settingsController.stream;
  }
}

/// List of settings that can be saved
enum SettingsList {
  /// The low cut off frequency for the band pass filter
  bandPassHighCutOff,

  /// The high cut off frequency for the band pass filter
  bandPassLowCutOff,

  /// The number of channels
  numberOfChannels,
}
