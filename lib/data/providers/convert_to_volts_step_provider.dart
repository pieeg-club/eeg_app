import 'package:eeg_app/data/repositories/processing_steps/covert_to_volts_step.dart';
import 'package:eeg_app/domain/repositories/processing_step_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'convert_to_volts_step_provider.g.dart';

/// Provides the [CovertToVoltsStep] as a [ProcessingStepRepo] for the app
/// to use.
@Riverpod(keepAlive: true)
ProcessingStepRepo<List<List<double>>, List<List<int>>> convertToVolts(
  Ref ref,
) {
  return CovertToVoltsStep();
}
