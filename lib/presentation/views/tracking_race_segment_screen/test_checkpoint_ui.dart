import 'package:flutter/material.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/checkpoint_dialog.dart';

class TestCheckpointScreen extends StatelessWidget {
  const TestCheckpointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkpoint Test')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Edit Checkpoint'),
          onPressed: () {
            showDialogModifyCheckpoin(
              context: context,
              currentBib: 'BIB001',
              finishTime: DateTime.now(),
              filterBIBs: ['BIB001', 'BIB002', 'BIB003'],
              onSaved: (newBib) {
                // For now, just print the result
                debugPrint('Saved BIB: $newBib');
                // debugPrint('Saved Note: $newNote');
              },
            );
          },
        ),
      ),
    );
  }
}
