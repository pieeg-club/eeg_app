import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/domain/entities/settings.dart';
import 'package:eeg_app/domain/providers/get_settings_use_case.dart';
import 'package:eeg_app/domain/providers/save_settings_use_case.dart';
import 'package:eeg_app/domain/use_cases/save_settings_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings.g.dart';

/// Notifier for settings
@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Future<Settings> build() async {
    final getSettingsUseCase = ref.read(getSettingsUseCaseProvider);
    final settings = await getSettingsUseCase(NoParams());
    return settings.fold(
      (failure) {
        throw Exception(failure.message);
      },
      (data) {
        return data;
      },
    );
  }

  /// Save the settings
  ///
  /// [settings] The settings to save
  Future<Either<Failure, Unit>> saveSettings(Settings settings) {
    final saveSettingsUseCase = ref.read(saveSettingsUseCaseProvider);
    final params = Params(settings);
    return saveSettingsUseCase(params);
  }
}
