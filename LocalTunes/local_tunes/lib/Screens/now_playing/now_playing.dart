import 'package:flutter/material.dart';
import 'package:local_tunes/Methods/methods.dart';
import 'package:local_tunes/Theme/theme.dart';
import 'package:local_tunes/Screens/now_playing/song.dart';
import 'package:local_tunes/Screens/now_playing/queue.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  final AudioPlayerManager playerManager = AudioPlayerManager();
  final List<String> screens = const ["Song", "Queue"];
  final List<Widget> screenWidgets = const [SongPage(), QueuePage()];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Now Playing")),
        backgroundColor: mainColors[0],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // tap buttons to switch between song details and queue
            Row(
              children: [
                // Song Details Button
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(screens[0], style: textStyles[4]),
                            SizedBox(width: 5),
                            Icon(Icons.music_note_sharp, size: 25),
                          ],
                        ),
                        SizedBox(height: 5),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          height: 3,
                          width: double.infinity,
                          color: index == 0 ? mainColors[3] : mainColors[4],
                        ),
                      ],
                    ),
                  ),
                ),

                // Queue Button
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(screens[1], style: textStyles[4]),
                            SizedBox(width: 5),
                            Icon(Icons.queue_music, size: 25),
                          ],
                        ),
                        SizedBox(height: 5),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          height: 3,
                          width: double.infinity,
                          color: index == 1 ? mainColors[3] : mainColors[4],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: screenWidgets[index],
              ),
            ),
            const SizedBox(height: 10),

            // Progress bar + Controls
            StreamBuilder<Duration>(
              stream: playerManager.player.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final total = playerManager.player.duration ?? Duration.zero;
                final maxSeconds = total.inSeconds > 0
                    ? total.inSeconds.toDouble()
                    : 1.0;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDuration(position.inMilliseconds),
                            style: textStyles[2],
                          ),
                          Text(
                            formatDuration(total.inMilliseconds),
                            textAlign: TextAlign.end,
                            style: textStyles[2],
                          ),
                        ],
                      ),

                      Slider(
                        value: position.inSeconds
                            .clamp(0, maxSeconds)
                            .toDouble(),
                        max: maxSeconds,
                        onChanged: (value) {
                          playerManager.player.seek(
                            Duration(seconds: value.toInt()),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 50,
                  color: mainColors[1],
                  icon: Icon(Icons.skip_previous_rounded),
                  onPressed: () {
                    playerManager.player.seekToPrevious();
                  },
                ),

                SizedBox(width: 20),

                IconButton(
                  iconSize: 50,
                  color: mainColors[1],
                  icon: StreamBuilder<bool>(
                    stream: playerManager.player.playingStream,
                    builder: (context, snapshot) {
                      final playing = snapshot.data ?? false;
                      return Icon(
                        playing
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                      );
                    },
                  ),
                  onPressed: () {
                    final player = playerManager.player;
                    player.playing ? player.pause() : player.play();
                  },
                ),

                SizedBox(width: 20),

                IconButton(
                  iconSize: 50,
                  color: mainColors[1],
                  icon: Icon(Icons.skip_next_rounded),
                  onPressed: () {
                    playerManager.player.seekToNext();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
