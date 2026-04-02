import 'package:flutter/material.dart';
import 'package:local_tunes/Methods/methods.dart';
import 'package:local_tunes/Theme/theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class TracksPage extends StatefulWidget {
  const TracksPage({super.key});

  @override
  State<TracksPage> createState() => TracksPageState();
}

class TracksPageState extends State<TracksPage> {
  final AudioPlayerManager playerManager = AudioPlayerManager();
  List<SongModel> songs = [];
  bool isLodading = true;

  @override
  void initState() {
    super.initState();
    () async {
      var list = await loadSongs();
      setState(() {
        songs = list;
        isLodading = false;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          isLodading
              ? const Center(child: CircularProgressIndicator())
              : songs.isEmpty
              ? const Center(child: Text("No songs found"))
              : ListView.separated(
                  itemCount: songs.length,
                  separatorBuilder: (context, index) => Container(
                    height: 0.8,
                    color: mainColors[3],
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  itemBuilder: (context, index) {
                    final song = songs[index];

                    return ListTile(
                      onTap: () async {
                        await playerManager.playSongs(songs, index);
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      // Album artwork
                      leading: QueryArtworkWidget(
                        id: song.id,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.cover,
                        artworkBorder: BorderRadius.all(Radius.circular(0)),
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
                        style: textStyles[1],
                      ),
                      subtitle: Text(
                        song.artist ?? "Unknown Artist",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles[2],
                      ),

                      // Song duration
                      trailing: Text(
                        formatDuration(song.duration ?? 0),
                        style: textStyles[3],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
