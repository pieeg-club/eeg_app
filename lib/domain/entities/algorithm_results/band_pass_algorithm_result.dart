import 'package:eeg_app/domain/entities/algorithm_results/algorithm_result.dart';

class BandPassAlgorithmResult implements AlgorithmResult {
  final List<double> result;

  BandPassAlgorithmResult(this.result);
}
