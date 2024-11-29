import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/entities/settings.dart';
import 'package:eeg_app/domain/failures/settings_failures.dart';
import 'package:eeg_app/domain/repositories/settings_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of the settings repository
class SettingsRepoImpl implements SettingsRepo {
  @override
  Future<Either<SettingsFailures, Settings>> getSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bandPassHighCutOff = prefs.getDouble(
            SettingsList.bandPassHighCutOff.name,
          ) ??
          30.0;
      final bandPassLowCutOff = prefs.getDouble(
            SettingsList.bandPassLowCutOff.name,
          ) ??
          0.0;
      return right(
        Settings(
          bandPassHighCutOff: bandPassHighCutOff,
          bandPassLowCutOff: bandPassLowCutOff,
        ),
      );
    } catch (e, s) {
      log('Failed to get settings', error: e, stackTrace: s);
      return left(SettingsFailures.unknown(s));
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(
        SettingsList.bandPassHighCutOff.name,
        settings.bandPassHighCutOff,
      );
      await prefs.setDouble(
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
