/// Settings entity, contains all the settings
class Settings {
  /// Settings constructor
  Settings({
    required this.bandPathHighCut,
    required this.bandPathLowCut,
  });

  /// Band path high cut
  final double bandPathHighCut;

  /// Band path low cut
  final double bandPathLowCut;
}
