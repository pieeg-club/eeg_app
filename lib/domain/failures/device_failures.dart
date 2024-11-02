import 'package:eeg_app/core/failure.dart';

/// Represents a failure related to a device.
///
/// This is an abstract class that extends [Failure].
/// It contains a message describing the failure.
sealed class DeviceFailure extends Failure {
  /// Constructs a [DeviceFailure] with the given [message].
  const DeviceFailure(super.message);

  /// Factory constructor for creating a `FailedToConnectFailure` instance.
  factory DeviceFailure.failedToConnect() => const FailedToConnectFailure._();

  /// Factory constructor for creating an `UnconnectedDeviceFailure` instance.
  factory DeviceFailure.unconnectedDevice() =>
      const UnconnectedDeviceFailure._();

  /// Factory constructor for creating a `NoDataStreamFailure` instance.
  factory DeviceFailure.noDataStream() => const NoDataStreamFailure._();

  /// Factory constructor for creating an `UnknownDeviceFailure` instance.
  factory DeviceFailure.unknown() => const UnknownDeviceFailure._();
}

/// Represents a failure when the device fails to connect.
///
/// This class extends [DeviceFailure] with a predefined message.
class FailedToConnectFailure extends DeviceFailure {
  /// Constructs a [FailedToConnectFailure].
  const FailedToConnectFailure._() : super('Failed to connect to device');
}

/// Represents a failure when no device is connected.
///
/// This class extends [DeviceFailure] with a predefined message.
class UnconnectedDeviceFailure extends DeviceFailure {
  /// Constructs an [UnconnectedDeviceFailure].
  const UnconnectedDeviceFailure._() : super('No device connected');
}

/// Represents a failure when no data stream is available.
///
/// This class extends [DeviceFailure] with a predefined message.
class NoDataStreamFailure extends DeviceFailure {
  /// Constructs a [NoDataStreamFailure].
  const NoDataStreamFailure._() : super('No data stream available');
}

/// Represents an unknown device failure.
///
/// This class extends [DeviceFailure] with a predefined message.
class UnknownDeviceFailure extends DeviceFailure {
  /// Constructs an [UnknownDeviceFailure].
  const UnknownDeviceFailure._() : super('Unknown device failure');
}
