import 'package:eeg_app/data/repositories/log_repo_impl.dart';
import 'package:eeg_app/domain/repositories/log_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'log_repo_impl_provider.g.dart';

/// A provider that creates a [LogRepo].
@Riverpod(keepAlive: true)
LogRepo logRepo(Ref ref) {
  return LogRepoImpl();
}
