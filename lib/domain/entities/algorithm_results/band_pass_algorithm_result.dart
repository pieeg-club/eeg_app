import 'package:eeg_app/domain/entities/algorithm_results/algorithm_result.dart';

/// Band pass algorithm result
class BandPassAlgorithmResult implements AlgorithmResult {
  /// Default constructor
  BandPassAlgorithmResult(this._result);

  final List<List<double>> _result;

  /// Getter for the result
  List<List<double>> get result => _result;
}
