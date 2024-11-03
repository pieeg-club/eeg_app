import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/data/providers/device_repo_impl_provider.dart';
import 'package:eeg_app/domain/use_cases/disconnect_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'disconnect_use_case.g.dart';

/// A provider that creates a [DisconnectUseCase].
@riverpod
UseCase<Unit, NoParams> disconnectUseCase(Ref ref) {
  final deviceRepo = ref.read(deviceRepoProvider);
  return DisconnectUseCase(deviceRepo);
}
