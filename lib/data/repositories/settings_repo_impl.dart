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

  @override
  Future<Settings> getSettings() async {
    try {
      final bandPassHighCutOff = await _asyncPrefs.getDouble(
        SettingsList.bandPassHighCutOff.name,
      );
      final bandPassLowCutOff = await _asyncPrefs.getDouble(
        SettingsList.bandPassLowCutOff.name,
      );
      return Settings(
        bandPassHighCutOff: bandPassHighCutOff!,
        bandPassLowCutOff: bandPassLowCutOff!,
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
      return right(unit);
    } catch (e, s) {
      log('Failed to save settings', error: e, stackTrace: s);
      return left(SettingsFailures.unknown(s));
    }
  }
}

/// List of settings that can be saved
enum SettingsList {
  /// The low cut off frequency for the band pass filter
  bandPassHighCutOff,

  /// The high cut off frequency for the band pass filter
  bandPassLowCutOff,
}
