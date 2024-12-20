import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/failures/device_failures.dart';

/// Abstract class for device repository.
abstract class DeviceRepo {
  /// Connects to a device.
  Future<Either<DeviceFailure, Unit>> connect();

  /// Disconnects from the connected device.
  Future<Either<DeviceFailure, Unit>> disconnect();

  /// Returns a stream of data from the connected device.
  Future<Either<DeviceFailure, Stream<List<int>>>> getDataStream();

  /// Checks if the device is connected.
  Future<Either<DeviceFailure, bool>> isConnected();
}
