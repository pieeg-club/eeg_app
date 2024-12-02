import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/entities/settings.dart';
import 'package:eeg_app/domain/repositories/settings_repo.dart';

/// A use case that gets the settings.
class GetSettings implements UseCase<Settings, NoParams> {
  /// Constructs a [GetSettings] with the given [SettingsRepo].
  const GetSettings(this._settingsRepo);

  final SettingsRepo _settingsRepo;

  @override
  Future<Either<Failure, Settings>> call(NoParams params) async {
    return Right(await _settingsRepo.getSettings());
  }
}
