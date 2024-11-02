import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/data/providers/device_repo_impl_provider.dart';
import 'package:eeg_app/domain/use_cases/connect_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connect_use_case.g.dart';

/// A provider that creates a [ConnectUseCase].
@riverpod
UseCase<Unit, NoParams> connectUseCase(Ref ref) {
  final deviceRepo = ref.read(deviceRepoProvider);
  return ConnectUseCase(deviceRepo);
}
