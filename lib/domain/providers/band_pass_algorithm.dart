import 'package:eeg_app/data/providers/processing_steps/band_pass_step_provider.dart';
import 'package:eeg_app/data/providers/processing_steps/convert_to_volts_step_provider.dart';
import 'package:eeg_app/data/providers/processing_steps/split_into_channels_step_provider.dart';
import 'package:eeg_app/domain/algorithms/algorithm.dart';
import 'package:eeg_app/domain/algorithms/band_pass_algorithm.dart';
import 'package:eeg_app/domain/entities/algorithm_results/band_pass_algorithm_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'band_pass_algorithm.g.dart';

/// A provider that creates a [Algorithm] that
/// returns a [BandPassAlgorithmResult].
@riverpod
Algorithm<BandPassAlgorithmResult> bandPassAlgorithm(Ref ref) {
  final splitIntoChannels = ref.read(splitIntoChannelsProvider);
  final convertToVolts = ref.read(convertToVoltsProvider);
  final bandPassFilter = ref.read(bandPassStepProvider);
  return BandPassAlgorithm(splitIntoChannels, convertToVolts, bandPassFilter);
}
