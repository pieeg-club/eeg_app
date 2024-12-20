import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/data/providers/device_repo_impl_provider.dart';
import 'package:eeg_app/domain/use_cases/is_connected_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_connected_use_case.g.dart';

/// A provider that creates an use case that checks if the device is connected.
@riverpod
UseCase<bool, NoParams> isConnectedUseCase(Ref ref) {
  final deviceRepo = ref.read(deviceRepoProvider);
  return IsConnectedUseCase(deviceRepo);
}
