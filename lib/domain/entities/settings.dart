/// Settings entity, contains all the settings
class Settings {
  /// Settings constructor
  Settings({
    required this.bandPassHighCutOff,
    required this.bandPassLowCutOff,
  });

  /// Band pass high cut
  final double bandPassHighCutOff;

  /// Band pass low cut
  final double bandPassLowCutOff;
}
