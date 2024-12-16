import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/failures/processing_step_failures.dart';
import 'package:eeg_app/domain/repositories/processing_step_repo.dart';

/// Splits the input data into multiple channels
class SplitIntoChannelsStep
    implements ProcessingStepRepo<List<List<int>>, List<int>> {
  @override
  Future<Either<ProcessingStepFailure, List<List<int>>>> call(
    List<int> input, {
    int numberOfChannels = 4,
    int bytesPerSample = 3,
  }) async {
    final channelData = List.generate(
      numberOfChannels,
      (_) => <int>[],
      growable: false,
    );

    for (var sample = 0; sample < (input.length / bytesPerSample); sample++) {
      final channel = sample % numberOfChannels;
      channelData[channel].addAll(
        input.sublist(sample * bytesPerSample, (sample + 1) * bytesPerSample),
      );
    }

    return Right(channelData);
  }
}
