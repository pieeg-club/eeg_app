import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/entities/settings.dart';
import 'package:eeg_app/domain/failures/settings_failures.dart';

/// Abstract class for the settings repository
abstract class SettingsRepo {
  /// Save the settings locally
  Future<Either<SettingsFailures, Unit>> saveSettings(Settings settings);

  /// Get the settings
  Future<Settings> getSettings();
}
