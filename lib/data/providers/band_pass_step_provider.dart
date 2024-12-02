import 'package:eeg_app/data/providers/settings_repo_impl_provider.dart';
import 'package:eeg_app/data/repositories/processing_steps/band_pass_step.dart';
import 'package:eeg_app/domain/repositories/processing_step_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'band_pass_step_provider.g.dart';

/// Provides the [BandPassStep] as a [ProcessingStepRepo] for the app
@Riverpod(keepAlive: true)
ProcessingStepRepo<List<double>, List<double>> bandPassStep(Ref ref) {
  final settingsRepo = ref.read(settingsRepoProvider);
  return BandPassStep(settingsRepo);
}
