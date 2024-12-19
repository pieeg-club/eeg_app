import 'package:eeg_app/presentation/notifiers/files_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dialog for files info
class FilesInfoDialog extends ConsumerWidget {
  /// Default constructor
  const FilesInfoDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filesInfo = ref.watch(filesInfoNotifierProvider);
    final filesInfoNotifier = ref.read(filesInfoNotifierProvider.notifier);
    return AlertDialog(
      title: const Text('Files Info'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
      content: filesInfo.when(
        error: (e, s) => Text(e.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (filesInfo) => SizedBox(
          width: MediaQuery.of(context).size.width * 0.7, // 70% of screen width
          height:
              MediaQuery.of(context).size.height * 0.5, // 50% of screen height
          child: ListView.builder(
            itemCount: filesInfo.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(filesInfo[index].name),
                subtitle: Text('${filesInfo[index].size} bytes'),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final result = await filesInfoNotifier
                              .shareFile(filesInfo[index]);
                          result.fold(
                            (failure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(failure.message),
                                ),
                              );
                            },
                            (data) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Successfully shared!'),
                                  duration: Duration(
                                    seconds: 2,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.share),
                      ),
                      IconButton(
                        onPressed: () async {
                          final result = await filesInfoNotifier
                              .deleteFileInfo(filesInfo[index]);
                          result.fold(
                            (failure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(failure.message),
                                ),
                              );
                            },
                            (data) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Successfully deleted!'),
                                  duration: Duration(
                                    seconds: 2,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
