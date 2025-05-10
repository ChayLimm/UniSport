import 'package:flutter/material.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/checkpoint_dialog.dart';

class TestCheckpointScreen extends StatelessWidget {
  const TestCheckpointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkpoint Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Edit Checkpoint Button
            ElevatedButton(
              child: const Text('Edit Checkpoint'),
              onPressed: () {
                showDialogModifyCheckpoint(
                  context: context,
                  currentBib: 'BIB001',
                  finishTime: DateTime.now(),
                  filterBIBs: ['BIB001', 'BIB002', 'BIB003'],
                  onSaved: (newBib) {
                    debugPrint('Saved BIB (Edit): $newBib');
                  },
                );
              },
            ),
            const SizedBox(height: 20),

            // 2-Step Record Button
            ElevatedButton(
              child: const Text('2-Step Record'),
              onPressed: () {
                showDialogModifyCheckpoint(
                  context: context,
                  finishTime: DateTime.now(),
                  filterBIBs: ['BIB004', 'BIB005', 'BIB006'],
                  onSaved: (newBib) {
                    debugPrint('Saved BIB (2-Step): $newBib');
                  },
                  isTwoStepRecord: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
