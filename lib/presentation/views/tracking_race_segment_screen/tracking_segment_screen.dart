import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitime/domain/model/checkpoint.dart';
import 'package:unitime/domain/model/participant.dart';
import 'package:unitime/domain/model/segment.dart';
import 'package:unitime/domain/services/checkpoint_service.dart';
import 'package:unitime/presentation/provider/checkpoint_provider.dart';
import 'package:unitime/presentation/provider/participant_provider.dart';
import 'package:unitime/presentation/provider/race_provider.dart';
import 'package:unitime/presentation/themes/theme.dart';
import 'package:unitime/presentation/views/race_segment_screen/race_segment_screen.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/checkpoint_dialog.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/widget/finished_bib_number.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/widget/search_bar.dart';
import 'package:unitime/presentation/views/tracking_race_segment_screen/widget/unfinished_bib_number.dart';
import 'package:unitime/presentation/widgets/UniButton.dart';
import 'package:unitime/presentation/widgets/custom_snackbar.dart';
import 'package:unitime/presentation/widgets/label.dart';
import 'package:unitime/presentation/widgets/timer.dart';
import 'package:unitime/presentation/widgets/uni_appbar.dart';
import 'package:unitime/utils/formatter.dart';

class TrackingRaceSegmentScreen extends StatefulWidget {
  final Segment segment;
  const TrackingRaceSegmentScreen({super.key, required this.segment});

  @override
  State<TrackingRaceSegmentScreen> createState() =>
      _TrackingRaceSegmentScreenState();
}

class _TrackingRaceSegmentScreenState extends State<TrackingRaceSegmentScreen> {
  List<Checkpoint> twoStep = [];
  List<Participant> filteredParticipants = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initAsync();
    });
  }

  Future<void> onEdit(Participant selectedParticipant, Duration duration,
    Checkpoint checkpoint) async {
    final raceProvider = context.read<RaceProvider>();
    final result = await showDialogModifyCheckpoint(
      segment: widget.segment,
      context: context,
      selectedParticipant: selectedParticipant,
      duration: duration,
      filterBIBs: raceProvider.currentParticipant.map((e) => e.bibNumber).toList(),
      checkpoint: checkpoint,
    );
    
    await _initAsync();
  }

  // Narong code
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  // Narong code
  void onSearchChanged() {
    setState(() {
      isSearching = searchController.text.isNotEmpty;
    });
  }

  Future<void> _initAsync() async {
    final raceProvider = Provider.of<RaceProvider>(context, listen: false);

    raceProvider.start(raceProvider.seletectedRace!.startTime!);
    await renderUnknownCheckpoint();
    await checkSegmentIfFinish();
  }

  Future<void> checkSegmentIfFinish() async {
    // Fetch checkpoints
    final checkpointProvider =
        Provider.of<CheckpointProvider>(context, listen: false);
    final raceProvider = Provider.of<RaceProvider>(context, listen: false);
    await checkpointProvider.getCheckpointsBySegmentId(widget.segment.id);
    // Check if segment is finished
    int size = raceProvider.currentParticipant.length;
    if (size == checkpointProvider.checkpoints.length) {
      raceProvider.markSegmentFinish(widget.segment.id);
    }
  }

  Future<void> renderUnknownCheckpoint() async {
    twoStep.clear();
    final checkpoints = await CheckpointService.instance.getAllCheckpoints();
    for (Checkpoint checkpoint in checkpoints) {
      if (checkpoint.participantId == null &&
          checkpoint.segmentId == widget.segment.id) {
        twoStep.add(checkpoint);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final raceProvider = Provider.of<RaceProvider>(context, listen: true);
    final participantProvider = Provider.of<ParticipantProvider>(context);

    // kyim code
    // List<Participant> participants = raceProvider.currentParticipant;

    // Narong code
    List<Participant> participants =
        isSearching ? filteredParticipants : raceProvider.currentParticipant;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            UniAppbar(
              segment: widget.segment,
              race: raceProvider.seletectedRace!,
              tirggerNavigator: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RaceSegmentScreen()));
              },
            ),
            const SizedBox(height: 10),
            const StopWatch(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Label(label: "Participants"),
                Expanded(child: SizedBox(width: 100)),
                CustomSearchbar(
                  controller: searchController,
                  // Narong code
                  onChanged: (value) {
                    filteredParticipants =
                        participantProvider.searchParticipants(
                            value, raceProvider.currentParticipant);
                    print(participants);
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Wrap(
                      spacing: 5,
                      runSpacing: 10,
                      children: List.generate(participants.length, (index) {
                        final bibNumber = participants[index].bibNumber;
                        return Consumer2<CheckpointProvider, RaceProvider>(
                          builder: (context, checkpointProvider, raceProvider,
                              child) {
                            final isFinished = checkpointProvider.isCompleted(
                              widget.segment.id,
                              participants[index].id!,
                            );
                            return InkWell(
                              onTap: () async {
                                // print("${{segment.name}} $bibNumber tapped");
                                // print("Checkpoint ID: ${segment.id}");
                                if (!isFinished) {
                                  // Pass BuildContext to recordCheckpoint method
                                  bool isSuccess =
                                      await checkpointProvider.recordCheckpoint(
                                    participantId: participants[index].id!,
                                    segmentId: widget.segment.id,
                                  );
                                  if (isSuccess) {
                                    UniSportSnackbar.show(
                                        context: context,
                                        message: "Record successfully",
                                        backgroundColor: UniColor.primary);
                                    checkpointProvider.refresh();
                                    await checkSegmentIfFinish();
                                  } else {
                                    UniSportSnackbar.show(
                                        context: context,
                                        message: "Record failed",
                                        backgroundColor: UniColor.red);
                                  }
                                }
                              },
                              child: isFinished
                                  ? FinishedBibNumber(
                                      selectedParticipant: participants[index],
                                      checkpoint: checkpointProvider
                                          .getParticipantCheckpointTime(
                                        widget.segment.id,
                                        participants[index].id!,
                                      ),
                                      onPressed: onEdit,
                                    )
                                  : UnFinishedBibNumber(bibNumber: bibNumber),
                            );
                          },
                        );
                      }),
                    ),
                    if (twoStep.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      const Label(label: "Two-step Recordings"),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 5,
                        runSpacing: 10,
                        children: List.generate(
                          twoStep.length,
                          (index) => FinishedBibNumber(
                              selectedParticipant: Participant(
                                  id: 0,
                                  raceId: 0,
                                  userName: "None",
                                  bibNumber: "Unknown",
                                  registerTime: DateTime.now(),
                                  createAt: DateTime.now(),
                                  updateAt: DateTime.now(),
                                  age: 0,
                                  gender: "male"),
                              checkpoint: twoStep[index],
                              onPressed: onEdit),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            UniButton(
              onTrigger: () async {
                // Additional logic for 2-step record button
                Checkpoint newStep = Checkpoint(
                    segmentId: widget.segment.id,
                    checkpointTime: DateTime.now(),
                    createAt: DateTime.now(),
                    updateAt: DateTime.now());
                final reponse = await CheckpointService.instance.recordCheckpoint(newStep);
                final formattedDuration = formatDuration(newStep.createAt.difference(raceProvider.seletectedRace!.startTime!));
                twoStep.add(reponse!);
                UniSportSnackbar.show(
                  message: "Recorded $formattedDuration",
                  context: context,
                  backgroundColor: UniColor.primary
                );
              },
              color: UniColor.primary,
              label: "2 Step Record",
            ),
          ],
        ),
      ),
    );
  }
}
