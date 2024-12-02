import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/entities/settings.dart';
import 'package:eeg_app/domain/repositories/settings_repo.dart';

/// A use case that saves the settings.
class SaveSettings implements UseCase<Unit, Params> {
  /// Constructs a [SaveSettings] with the given [SettingsRepo].
  const SaveSettings(this._settingsRepo);

  final SettingsRepo _settingsRepo;

  @override
  Future<Either<Failure, Unit>> call(Params params) {
    return _settingsRepo.saveSettings(params.settings);
  }
}

/// Parameters for the [SaveSettings] use case.
class Params {
  /// Constructs a [Params] with the given [Settings].
  Params(this.settings);

  /// The settings to save.
  final Settings settings;
}
