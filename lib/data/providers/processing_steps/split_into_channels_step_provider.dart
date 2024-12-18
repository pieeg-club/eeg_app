import 'package:eeg_app/data/repositories/processing_steps/split_into_channels_step.dart';
import 'package:eeg_app/domain/repositories/processing_step_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'split_into_channels_step_provider.g.dart';

/// Provider for the [SplitIntoChannelsStep] class.
/// This provider is used to instantiate the [SplitIntoChannelsStep] class.
@riverpod
ProcessingStepRepo<List<List<int>>, List<int>> splitIntoChannels(Ref ref) {
  return SplitIntoChannelsStep();
}
