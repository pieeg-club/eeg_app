/// Settings entity, contains all the settings
class Settings {
  /// Settings constructor
  Settings({
    required this.bandPassHighCutOff,
    required this.bandPassLowCutOff,
    required this.numberOfChannels,
  });

  /// Default settings
  factory Settings.defaultSettings() {
    return Settings(
      bandPassHighCutOff: 30,
      bandPassLowCutOff: 0.5,
      numberOfChannels: 4,
    );
  }

  /// Band pass high cut
  final double bandPassHighCutOff;

  /// Band pass low cut
  final double bandPassLowCutOff;

  /// Number of channels
  final int numberOfChannels;

  /// Copy with method
  Settings copyWith({
    double? bandPassHighCutOff,
    double? bandPassLowCutOff,
    int? numberOfChannels,
  }) {
    return Settings(
      bandPassHighCutOff: bandPassHighCutOff ?? this.bandPassHighCutOff,
      bandPassLowCutOff: bandPassLowCutOff ?? this.bandPassLowCutOff,
      numberOfChannels: numberOfChannels ?? this.numberOfChannels,
    );
  }
}
