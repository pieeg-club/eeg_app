import 'package:eeg_app/data/repositories/data_storage_repo_impl.dart';
import 'package:eeg_app/domain/repositories/data_storage_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_storage_provider.g.dart';

/// A provider that creates a [DataStorageRepo].
@Riverpod(keepAlive: true)
DataStorageRepo dataStorageRepo(Ref ref) {
  return DataStorageRepoImpl();
}
