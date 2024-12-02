import 'package:dartz/dartz.dart';
import 'package:eeg_app/core/failure.dart';
import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/data/providers/device_repo_impl_provider.dart';
import 'package:eeg_app/domain/entities/algorithm_results/algorithm_result.dart';
import 'package:eeg_app/domain/use_cases/get_processed_data_stream_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_processed_data_stream_use_case.g.dart';

/// A provider that creates a [].
@riverpod
UseCase<Stream<Either<Failure, AlgorithmResult>>, NoParams>
    getProcessedDataStreamUseCase(
  Ref ref,
) {
  final deviceRepo = ref.read(deviceRepoProvider);
  return GetProcessedDataStreamUseCase(deviceRepo);
}
