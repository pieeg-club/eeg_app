import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/failures/processing_step_failures.dart';
import 'package:eeg_app/domain/repositories/processing_step_repo.dart';
import 'package:eeg_app/domain/repositories/settings_repo.dart';
import 'package:iirjdart/butterworth.dart';

const double _samplingFrequency = 250;
const int _order = 5;

/// Band pass filter for the input data
class BandPassStep
    implements ProcessingStepRepo<List<List<double>>, List<List<double>>> {
  /// Constructor for the band pass filter
  BandPassStep(this._settings)
      : _butterworths = List.generate(4, (_) => Butterworth()) {
    _initializeBandPassFilters();
  }

  final List<Butterworth> _butterworths;
  final SettingsRepo _settings;

  @override
  Future<Either<ProcessingStepFailure, List<List<double>>>> call(
    List<List<double>> input,
  ) async {
    final output = List<List<double>>.generate(
      input.length,
      (_) => List<double>.filled(input[0].length, 0),
    );
    for (var channel = 0; channel < input.length; channel++) {
      for (var i = 0; i < input[channel].length; i++) {
        output[channel][i] = _butterworths[channel].filter(input[channel][i]);
      }
    }
    return Right(output);
  }

  Future<void> _initializeBandPassFilters() async {
    final settings = await _settings.getSettings();
    var leftCutOffFreq = 0.0;
    var rightCutOffFreq = 0.0;
    leftCutOffFreq = settings.bandPassLowCutOff;
    rightCutOffFreq = settings.bandPassHighCutOff;
    final centerFreq = (rightCutOffFreq + leftCutOffFreq) / 2;
    final widthInFreq = rightCutOffFreq - leftCutOffFreq;
    for (final filter in _butterworths) {
      filter.bandPass(_order, _samplingFrequency, centerFreq, widthInFreq);
    }
  }
}
