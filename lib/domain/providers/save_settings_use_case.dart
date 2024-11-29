import 'package:eeg_app/data/providers/settings_repo_impl_provider.dart';
import 'package:eeg_app/domain/use_cases/save_settings_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'save_settings_use_case.g.dart';

/// Save settings provider for the use case [SaveSettings]
@riverpod
SaveSettings saveSettings(Ref ref) {
  final settindsRepo = ref.read(settingsRepoProvider);
  return SaveSettings(settindsRepo);
}
