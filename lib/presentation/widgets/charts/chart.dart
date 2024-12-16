import 'package:eeg_app/domain/entities/algorithm_results/algorithm_result.dart';
import 'package:eeg_app/domain/entities/algorithm_results/band_pass_algorithm_result.dart';
import 'package:eeg_app/presentation/widgets/charts/band_pass_chart.dart';
import 'package:flutter/material.dart';

/// Chart widget
///
/// Displays a chart based on the data provided
class Chart extends StatelessWidget {
  /// Default constructor
  const Chart({required this.data, super.key});

  /// Data to be displayed
  final AlgorithmResult data;

  @override
  Widget build(BuildContext context) {
    if (data is BandPassAlgorithmResult) {
      return BandPassChart(data: data as BandPassAlgorithmResult);
    } else {
      return Container(
        height: 200,
        width: 200,
        color: Colors.blue,
        child: Text('AlgorithmResult'),
      );
    }
  }
}
