import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:local_tunes/Methods/methods.dart';
import 'package:local_tunes/Screens/now_playing.dart';
import 'package:local_tunes/Theme/theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  final SongModel song;

  const MiniPlayer({super.key, required this.song});

  @override
  State<MiniPlayer> createState() => MiniPlayerState();
}

class MiniPlayerState extends State<MiniPlayer> {
  final AudioPlayerManager playerManager = AudioPlayerManager();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NowPlayingPage()),
        );
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: mainColors[5],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),

            // Artwork
            QueryArtworkWidget(
              id: widget.song.id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: const Icon(Icons.music_note),
            ),

            const SizedBox(width: 12),

            // Title + Artist + Progress
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyles[1],
                  ),

                  Text(
                    widget.song.artist ?? "Unknown",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyles[2],
                  ),

                  const SizedBox(height: 6),

                  // Progress bar
                  StreamBuilder<Duration>(
                    stream: playerManager.positionStream,
                    builder: (context, snapshot) {
                      final position = snapshot.data ?? Duration.zero;

                      return StreamBuilder<Duration?>(
                        stream: playerManager.durationStream,
                        builder: (context, snapshot) {
                          final duration = snapshot.data ?? Duration.zero;

                          return ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                mainColors[3],
                              ),
                              backgroundColor: mainColors[1],
                              value: duration.inMilliseconds == 0
                                  ? 0
                                  : position.inMilliseconds /
                                        duration.inMilliseconds,
                              minHeight: 3,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            // Play/Pause
            IconButton(
              icon: StreamBuilder<PlayerState>(
                stream: playerManager.player.playerStateStream,
                builder: (context, snapshot) {
                  final playing = snapshot.data?.playing ?? false;
                  return Icon(
                    playing ? Icons.pause : Icons.play_arrow,
                    color: mainColors[1],
                    size: 30,
                  );
                },
              ),
              onPressed: () {
                playerManager.player.playing
                    ? playerManager.player.pause()
                    : playerManager.player.play();
              },
            ),
          ],
        ),
      ),
    );
  }
}
