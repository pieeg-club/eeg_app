import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:eeg_app/domain/failures/device_failures.dart';
import 'package:eeg_app/domain/repositories/device_repo.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

const _characteristicUUID = '0000fe42-8e22-4541-9d4c-21edae82ed19';
const _platformName = 'EAREEG';

/// Implementation of the [DeviceRepo] interface for devices.
class BleDeviceImpl implements DeviceRepo {
  BluetoothDevice? _connectedDevice;

  @override
  Future<Either<DeviceFailure, Unit>> connect() async {
    if (_connectedDevice != null) {
      log('Device already connected', stackTrace: StackTrace.current);
      return left(DeviceFailure.failedToConnect(StackTrace.current));
    }

    try {
      final device = await _scanForDevice(
        platformName: _platformName,
        timeout: const Duration(seconds: 5),
      );
      await device.connect(timeout: const Duration(seconds: 5));
      _connectedDevice = device;
      return right(unit);
    } catch (e, s) {
      log('Failed to connect to device', error: e, stackTrace: s);
      return left(DeviceFailure.failedToConnect(s));
    }
  }

  @override
  Future<Either<DeviceFailure, Unit>> disconnect() async {
    if (_connectedDevice == null) {
      log('Device not connected', stackTrace: StackTrace.current);
      return left(DeviceFailure.unconnectedDevice(StackTrace.current));
    }

    try {
      await _connectedDevice!.disconnect(timeout: 5);
      _connectedDevice = null;
      return right(unit);
    } catch (e, s) {
      log('Failed to disconnect from device', error: e, stackTrace: s);
      return left(DeviceFailure.unknown(s));
    }
  }

  @override
  Future<Either<DeviceFailure, Stream<List<int>>>> getDataStream() async {
    if (_connectedDevice == null) {
      log('Device not connected', stackTrace: StackTrace.current);
      return left(DeviceFailure.unconnectedDevice(StackTrace.current));
    }

    try {
      final dataStream = await _dataStreamFromDevice(
        _connectedDevice!,
        _characteristicUUID,
      );
      return right(dataStream);
    } catch (e, s) {
      log('Failed to get data stream', error: e, stackTrace: s);
      return left(DeviceFailure.noDataStream(s));
    }
  }

  Future<BluetoothDevice> _scanForDevice({
    required String platformName,
    required Duration timeout,
  }) async {
    await FlutterBluePlus.startScan(
      timeout: timeout,
      androidUsesFineLocation: true,
    );
    final devices = await FlutterBluePlus.onScanResults
        .firstWhere(
          (result) => result.any((r) => r.device.platformName == platformName),
        )
        .timeout(timeout);

    final scanResult = devices.firstWhere(
      (scanResult) => scanResult.device.platformName == platformName,
    );
    return scanResult.device;
  }

  Future<Stream<List<int>>> _dataStreamFromDevice(
    BluetoothDevice device,
    String characteristicUUID,
  ) async {
    final characteristic = await _findCharacteristicByUuid(
      characteristicUUID: characteristicUUID,
      connectedDevice: device,
    );

    if (characteristic == null) {
      log('Characteristic not found', stackTrace: StackTrace.current);
      throw Exception('Characteristic not found');
    }

    await characteristic.setNotifyValue(true);
    return characteristic.onValueReceived;
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
