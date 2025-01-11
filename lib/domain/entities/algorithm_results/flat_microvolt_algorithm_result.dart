import 'package:eeg_app/domain/entities/algorithm_results/algorithm_result.dart';

/// Flat(not buffered) microvolt algorithm result for saving microvolt data.
///
/// Stores the results as a list of samples, where each sample is a list of
/// microvolt values for each channel.
/// Example: [[channel1_sample1, channel2_sample1],
/// [channel1_sample2, channel2_sample2]]
class FlatMicrovoltAlgorithmResult implements AlgorithmResult {
  /// Default constructor
  FlatMicrovoltAlgorithmResult(this._result);

  final List<List<double>> _result;

  /// Getter for the result
  List<List<double>> get result => _result;
}
