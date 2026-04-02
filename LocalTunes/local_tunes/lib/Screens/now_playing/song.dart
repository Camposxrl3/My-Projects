import 'package:flutter/material.dart';
import 'package:local_tunes/Methods/methods.dart';
import 'package:local_tunes/Theme/theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => SongPageState();
}

class SongPageState extends State<SongPage> {
  final AudioPlayerManager playerManager = AudioPlayerManager();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SongModel?>(
      valueListenable: playerManager.currentSongNotifier,
      builder: (context, song, child) {
        return song == null
            ? SizedBox()
            : Column(
                children: [
                  const SizedBox(height: 20),

                  // Album artwork
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: QueryArtworkWidget(
                            id: song.id,
                            type: ArtworkType.AUDIO,
                            size: 500,
                            artworkFit: BoxFit.cover,
                            artworkBorder: BorderRadius.all(Radius.circular(0)),
                            nullArtworkWidget: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    mainColors[0],
                                    mainColors[5],
                                    mainColors[0],
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              child: Icon(
                                Icons.music_note,
                                size: 80,
                                color: mainColors[3],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Song title
                  Text(
                    song.title,
                    style: textStyles[0].copyWith(color: mainColors[1]),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  // Artist name
                  Text(song.artist ?? "Unknown Artist", style: textStyles[4]),
                  const SizedBox(height: 10),

                  // Album name
                  Text(
                    song.album ?? "Unknown Album",
                    style: textStyles[1],
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
      },
    );
  }
}
