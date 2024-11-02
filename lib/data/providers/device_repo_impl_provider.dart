import 'package:eeg_app/data/repositories/ble_repo_impl.dart';
import 'package:eeg_app/domain/repositories/device_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_repo_impl_provider.g.dart';

/// A provider that creates a [DeviceRepo].
@riverpod
DeviceRepo deviceRepo(Ref ref) {
  return BleDeviceImpl();
}
