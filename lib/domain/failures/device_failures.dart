import 'package:eeg_app/core/failure.dart';

/// Represents a failure related to a device.
///
/// This is an abstract class that extends [Failure].
/// It contains a message describing the failure.
/// It contains a stack trace to help with debugging.
sealed class DeviceFailure extends Failure {
  /// Constructs a [DeviceFailure] with the given [message] and [stackTrace].
  const DeviceFailure(super.message, super.stackTrace);

  /// Factory constructor for creating a `FailedToConnectFailure` instance.
  factory DeviceFailure.failedToConnect(StackTrace stackTrace) =>
      FailedToConnectFailure._(stackTrace);

  /// Factory constructor for creating an `UnconnectedDeviceFailure` instance.
  factory DeviceFailure.unconnectedDevice(StackTrace stackTrace) =>
      UnconnectedDeviceFailure._(stackTrace);

  /// Factory constructor for creating a `NoDataStreamFailure` instance.
  factory DeviceFailure.noDataStream(StackTrace stackTrace) =>
      NoDataStreamFailure._(stackTrace);

  /// Factory constructor for creating an `UnknownDeviceFailure` instance.
  factory DeviceFailure.unknown(StackTrace stackTrace) =>
      UnknownDeviceFailure._(stackTrace);
}

/// Represents a failure when the device fails to connect.
///
/// This class extends [DeviceFailure] with a predefined message.
class FailedToConnectFailure extends DeviceFailure {
  /// Constructs a [FailedToConnectFailure].
  const FailedToConnectFailure._(StackTrace stackTrace)
      : super('Failed to connect to device', stackTrace);
}

/// Represents a failure when no device is connected.
///
/// This class extends [DeviceFailure] with a predefined message.
class UnconnectedDeviceFailure extends DeviceFailure {
  /// Constructs an [UnconnectedDeviceFailure].
  const UnconnectedDeviceFailure._(StackTrace stackTrace)
      : super('No device connected', stackTrace);
}

/// Represents a failure when no data stream is available.
///
/// This class extends [DeviceFailure] with a predefined message.
class NoDataStreamFailure extends DeviceFailure {
  /// Constructs a [NoDataStreamFailure].
  const NoDataStreamFailure._(StackTrace stackTrace)
      : super('No data stream available', stackTrace);
}

/// Represents an unknown device failure.
///
/// This class extends [DeviceFailure] with a predefined message.
class UnknownDeviceFailure extends DeviceFailure {
  /// Constructs an [UnknownDeviceFailure].
  const UnknownDeviceFailure._(StackTrace stackTrace)
      : super('Unknown device failure', stackTrace);
}
