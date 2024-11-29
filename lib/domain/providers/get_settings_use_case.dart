import 'package:eeg_app/data/providers/settings_repo_impl_provider.dart';
import 'package:eeg_app/domain/use_cases/get_settings_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_settings_use_case.g.dart';

/// Get settings provider for the use case [GetSettings]
@riverpod
GetSettings saveSettings(Ref ref) {
  final settindsRepo = ref.read(settingsRepoProvider);
  return GetSettings(settindsRepo);
}
