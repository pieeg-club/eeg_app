import 'package:eeg_app/data/providers/processing_steps/convert_to_volts_step_provider.dart';
import 'package:eeg_app/data/providers/processing_steps/split_into_channels_step_provider.dart';
import 'package:eeg_app/domain/algorithms/algorithm.dart';
import 'package:eeg_app/domain/algorithms/flat_microvolt_algorithm.dart';
import 'package:eeg_app/domain/entities/algorithm_results/flat_microvolt_algorithm_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flat_microvolt_algorithm.g.dart';

/// A provider that creates a [Algorithm] that
/// returns a [FlatMicrovoltAlgorithmResult].
@riverpod
Algorithm<FlatMicrovoltAlgorithmResult> flatMicrovoltAlgorithm(Ref ref) {
  final splitIntoChannels = ref.read(splitIntoChannelsProvider);
  final convertToVolts = ref.read(convertToVoltsProvider);
  return FlatMicrovoltAlgorithm(
    splitIntoChannels,
    convertToVolts,
  );
}
