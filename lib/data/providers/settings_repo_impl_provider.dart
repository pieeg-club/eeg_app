import 'package:eeg_app/data/repositories/settings_repo_impl.dart';
import 'package:eeg_app/domain/repositories/settings_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_repo_impl_provider.g.dart';

/// A provider that creates a [SettingsRepo].
@Riverpod(keepAlive: true)
SettingsRepo settingsRepo(Ref ref) {
  return SettingsRepoImpl();
}
