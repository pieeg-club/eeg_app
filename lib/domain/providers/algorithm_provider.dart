import 'package:eeg_app/data/providers/band_pass_step_provider.dart';
import 'package:eeg_app/data/providers/convert_to_volts_step_provider.dart';
import 'package:eeg_app/data/providers/split_into_channels_step_provider.dart';
import 'package:eeg_app/domain/algorithms/algorithm.dart';
import 'package:eeg_app/domain/algorithms/band_pass_algorithm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'algorithm_provider.g.dart';

/// A provider that creates a [Algorithm].
@riverpod
Algorithm algorithm(Ref ref) {
  final splitIntoChannels = ref.read(splitIntoChannelsProvider);
  final convertToVolts = ref.read(convertToVoltsProvider);
  final bandPassFilter = ref.read(bandPassStepProvider);
  return BandPassAlgorithm(splitIntoChannels, convertToVolts, bandPassFilter);
}
