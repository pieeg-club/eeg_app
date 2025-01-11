/// Settings entity, contains all the settings
class Settings {
  /// Settings constructor
  Settings({
    required this.bandPassHighCutOff,
    required this.bandPassLowCutOff,
    required this.numberOfChannels,
    required this.displayAlgorithmType,
    required this.saveAlgorithmType,
  });

  /// Default settings
  factory Settings.defaultSettings() {
    return Settings(
      bandPassHighCutOff: 30,
      bandPassLowCutOff: 0.5,
      numberOfChannels: 4,
      displayAlgorithmType: DisplayAlgorithmType.bandPass,
      saveAlgorithmType: SaveAlgorithmType.microvolts,
    );
  }

  /// Band pass high cut
  final double bandPassHighCutOff;

  /// Band pass low cut
  final double bandPassLowCutOff;

  /// Number of channels
  final int numberOfChannels;

  /// Display algorithm type
  final DisplayAlgorithmType displayAlgorithmType;

  /// Save algorithm type
  final SaveAlgorithmType saveAlgorithmType;

  /// Copy with method
  Settings copyWith({
    double? bandPassHighCutOff,
    double? bandPassLowCutOff,
    int? numberOfChannels,
    DisplayAlgorithmType? displayAlgorithmType,
    SaveAlgorithmType? saveAlgorithmType,
  }) {
    return Settings(
      bandPassHighCutOff: bandPassHighCutOff ?? this.bandPassHighCutOff,
      bandPassLowCutOff: bandPassLowCutOff ?? this.bandPassLowCutOff,
      numberOfChannels: numberOfChannels ?? this.numberOfChannels,
      displayAlgorithmType: displayAlgorithmType ?? this.displayAlgorithmType,
      saveAlgorithmType: saveAlgorithmType ?? this.saveAlgorithmType,
    );
  }
}

/// Dispaly algorithm type enum
enum DisplayAlgorithmType {
  /// Band pass
  bandPass,
}

/// Save algorithm type enum
enum SaveAlgorithmType {
  /// Band pass
  microvolts,
}
