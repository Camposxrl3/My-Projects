import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:local_tunes/Methods/methods.dart';
import 'package:local_tunes/Theme/theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({super.key});

  @override
  State<QueuePage> createState() => QueuePageState();
}

class QueuePageState extends State<QueuePage> {
  final AudioPlayerManager playerManager = AudioPlayerManager();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<SequenceState>(
        stream: playerManager.player.sequenceStateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;

          if (state!.sequence.isEmpty) {
            return const Center(child: Text("Queue is empty"));
          }
          final sequence = state.sequence;
          final currentIndex = state.currentIndex;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (currentIndex != null) {
              scrollController.animateTo(
                currentIndex * 72,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          });
          return ReorderableListView.builder(
            buildDefaultDragHandles: false,
            scrollController: scrollController,
            itemCount: sequence.length,
            onReorder: (oldIndex, newIndex) async {
              if (newIndex > oldIndex) newIndex -= 1;
              await playerManager.songsQueue.move(oldIndex, newIndex);
            },
            itemBuilder: (context, index) {
              final source = sequence[index] as UriAudioSource;
              final song = source.tag as SongModel;
              final isPlaying = index == currentIndex;
              return Dismissible(
                key: ValueKey(song.id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: mainColors[1]),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (_) async {
                  await playerManager.songsQueue.removeAt(index);
                },
                child: ListTile(
                  onTap: () {
                    playerManager.player.seek(Duration.zero, index: index);
                  },
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  // Album artwork
                  leading: QueryArtworkWidget(
                    id: song.id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Container(
                      width: 50,
                      height: 50,
                      color: mainColors[5],
                      child: const Icon(Icons.music_note),
                    ),
                  ),

                  // Song Name + Artist Name
                  title: Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: isPlaying
                        ? textStyles[1].copyWith(color: mainColors[3])
                        : textStyles[1],
                  ),
                  subtitle: Text(
                    song.artist ?? "Unknown Artist",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: isPlaying
                        ? textStyles[2].copyWith(color: mainColors[3])
                        : textStyles[2],
                  ),
                  // Duration + Playing indicator
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isPlaying
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.volume_up_rounded,
                                  color: mainColors[3],
                                ),
                                SizedBox(width: 5),
                                Text(
                                  formatDuration(song.duration ?? 0),
                                  style: textStyles[3].copyWith(
                                    color: mainColors[3],
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              formatDuration(song.duration ?? 0),
                              style: textStyles[3],
                            ),
                      SizedBox(width: 5),
                      ReorderableDelayedDragStartListener(
                        index: index,
                        child: Icon(Icons.menu, color: mainColors[1], size: 40),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
