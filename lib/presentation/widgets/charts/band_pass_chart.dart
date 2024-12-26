import 'package:eeg_app/domain/entities/algorithm_results/band_pass_algorithm_result.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Band pass chart widget
class BandPassChart extends StatelessWidget {
  /// Default constructor
  const BandPassChart({required this.data, super.key});

  /// Data to be displayed
  final BandPassAlgorithmResult data;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        data.result.length,
        (i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Channel: $i'),
              ),
              SingleChart(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 15),
                spots: data.result[i]
                    .asMap()
                    .entries
                    .map((e) => FlSpot(e.key.toDouble(), e.value))
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Chart widget
class SingleChart extends StatelessWidget {
  /// Default constructor
  const SingleChart({
    required List<FlSpot> spots,
    super.key,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  })  : _padding = padding,
        _spots = spots;

  final EdgeInsetsGeometry _padding;
  final List<FlSpot> _spots;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding,
      child: SizedBox(
        width: 300,
        height: 75,
        child: LineChart(
          duration: Duration.zero,
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                dotData: const FlDotData(show: false),
                barWidth: 0.5,
                spots: _spots,
              ),
            ],
            lineTouchData: const LineTouchData(enabled: false),
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(
              rightTitles: AxisTitles(),
              topTitles: AxisTitles(),
            ),
          ),
        ),
      ),
    );
  }
}
