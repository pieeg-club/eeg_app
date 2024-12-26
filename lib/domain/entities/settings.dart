/// Settings entity, contains all the settings
class Settings {
  /// Settings constructor
  Settings({
    required this.bandPassHighCutOff,
    required this.bandPassLowCutOff,
    required this.numberOfChannels,
    required this.algorithmType,
  });

  /// Default settings
  factory Settings.defaultSettings() {
    return Settings(
      bandPassHighCutOff: 30,
      bandPassLowCutOff: 0.5,
      numberOfChannels: 4,
      algorithmType: AlgorithmType.bandPass,
    );
  }

  /// Band pass high cut
  final double bandPassHighCutOff;

  /// Band pass low cut
  final double bandPassLowCutOff;

  /// Number of channels
  final int numberOfChannels;

  /// Algorithm type
  final AlgorithmType algorithmType;

  /// Copy with method
  Settings copyWith({
    double? bandPassHighCutOff,
    double? bandPassLowCutOff,
    int? numberOfChannels,
    AlgorithmType? algorithmType,
  }) {
    return Settings(
      bandPassHighCutOff: bandPassHighCutOff ?? this.bandPassHighCutOff,
      bandPassLowCutOff: bandPassLowCutOff ?? this.bandPassLowCutOff,
      numberOfChannels: numberOfChannels ?? this.numberOfChannels,
      algorithmType: algorithmType ?? this.algorithmType,
    );
  }
}

/// Algorithm type enum
enum AlgorithmType {
  /// Band pass
  bandPass,
}
