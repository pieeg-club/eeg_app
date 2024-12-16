import 'package:eeg_app/domain/entities/algorithm_results/algorithm_result.dart';

/// Band pass algorithm result
class BandPassAlgorithmResult implements AlgorithmResult {
  /// Default constructor
  BandPassAlgorithmResult(this.result);

  final List<List<double>> result;
}
