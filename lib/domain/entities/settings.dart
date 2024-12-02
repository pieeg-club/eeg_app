/// Settings entity, contains all the settings
class Settings {
  /// Settings constructor
  Settings({
    required this.bandPassHighCutOff,
    required this.bandPassLowCutOff,
  });

  /// Default settings
  factory Settings.defaultSettings() {
    return Settings(
      bandPassHighCutOff: 30,
      bandPassLowCutOff: 0,
    );
  }

  /// Band pass high cut
  final double bandPassHighCutOff;

  /// Band pass low cut
  final double bandPassLowCutOff;

  /// Copy with method
  Settings copyWith({
    double? bandPassHighCutOff,
    double? bandPassLowCutOff,
  }) {
    return Settings(
      bandPassHighCutOff: bandPassHighCutOff ?? this.bandPassHighCutOff,
      bandPassLowCutOff: bandPassLowCutOff ?? this.bandPassLowCutOff,
    );
  }
}
