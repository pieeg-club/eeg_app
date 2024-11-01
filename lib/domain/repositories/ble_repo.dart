/// Abstract class for BLE repository.
abstract class BleRepo {
  /// Connects to a BLE device.
  Future<void> connect();

  /// Disconnects from the connected BLE device.
  Future<void> disconnect();

  /// Returns a stream of data from the connected BLE device.
  Stream<List<List<double>>> getDataStream();
}
