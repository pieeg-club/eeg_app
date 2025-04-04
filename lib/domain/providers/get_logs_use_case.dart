import 'package:eeg_app/core/use_case.dart';
import 'package:eeg_app/data/providers/log_repo_impl_provider.dart';
import 'package:eeg_app/domain/use_cases/get_logs_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_logs_use_case.g.dart';

/// Use case to get logs
@riverpod
UseCase<List<String>, NoParams> getLogsUseCase(Ref ref) {
  final logRepo = ref.read(logRepoProvider);
  return GetLogsUseCase(logRepo);
}
