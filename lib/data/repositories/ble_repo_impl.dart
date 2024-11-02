import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/failures/device_failures.dart';
import 'package:eeg_app/domain/repositories/device_repo.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

const _characteristicUUID = '0000fe42-8e22-4541-9d4c-21edae82ed19';
const _platformName = 'EAREEG';

/// Implementation of the [DeviceRepo] interface for devices.
class BleDeviceImpl implements DeviceRepo {
  BluetoothDevice? _connectedDevice;
  Stream<List<int>>? _dataStream;

  @override
  Future<Either<DeviceFailure, Unit>> connect() async {
    if (_connectedDevice != null) {
      return left(DeviceFailure.failedToConnect(StackTrace.current));
    }
    final BluetoothDevice device;
    try {
      device = await _scanForDevice(_platformName);
    } catch (e, s) {
      return left(DeviceFailure.failedToConnect(s));
    }
    try {
      await device.connect();
    } catch (e, s) {
      return left(DeviceFailure.failedToConnect(s));
    }
    _connectedDevice = device;
    _dataStream = await _dataStreamFromDevice(
      _connectedDevice!,
      _characteristicUUID,
    );
    return right(unit);
  }

  @override
  Future<Either<DeviceFailure, Unit>> disconnect() async {
    if (_connectedDevice == null) {
      return left(DeviceFailure.unconnectedDevice(StackTrace.current));
    }
    await _connectedDevice!.disconnect();
    _connectedDevice = null;
    return right(unit);
  }

  @override
  Either<DeviceFailure, Stream<List<int>>> getDataStream() {
    if (_dataStream == null) {
      return left(DeviceFailure.noDataStream(StackTrace.current));
    }
    return right(_dataStream!);
  }

  Future<BluetoothDevice> _scanForDevice(String platformName) async {
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
    final devices = await Future.any<List<ScanResult>?>([
      FlutterBluePlus.onScanResults.firstWhere(
        (result) => result.any((r) => r.device.platformName == platformName),
      ),
      Future.delayed(const Duration(seconds: 10)),
    ]);
    return devices!.first.device;
  }

  Future<Stream<List<int>>?> _dataStreamFromDevice(
    BluetoothDevice device,
    String characteristicUUID,
  ) async {
    final characteristic = await _findCharacteristicByUuid(
      characteristicUUID: characteristicUUID,
      connectedDevice: device,
    );
    return characteristic?.lastValueStream;
  }

  Future<BluetoothCharacteristic?> _findCharacteristicByUuid({
    required String characteristicUUID,
    required BluetoothDevice connectedDevice,
  }) async {
    final services = await connectedDevice.discoverServices();
    for (final service in services) {
      final characteristics = service.characteristics;
      for (final characteristic in characteristics) {
        if (characteristic.uuid.toString() == characteristicUUID) {
          return characteristic;
        }
      }
    }
    return null;
  }
}
