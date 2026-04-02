import 'package:flutter/material.dart';
import 'package:local_tunes/Methods/methods.dart';
import 'package:local_tunes/Screens/mini_player.dart';
import 'package:local_tunes/Theme/theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumTracksPage extends StatefulWidget {
  const AlbumTracksPage({super.key, required this.albumId});

  final int albumId;

  @override
  State<AlbumTracksPage> createState() => AlbumsTracksPageState();
}

class AlbumsTracksPageState extends State<AlbumTracksPage> {
  final AudioPlayerManager playerManager = AudioPlayerManager();
  final String title = "LocalTunes";
  List<SongModel> songs = [];
  bool isLodading = true;

  @override
  void initState() {
    super.initState();
    () async {
      var list = await loadAlbumtracks(widget.albumId);
      setState(() {
        songs = list;
        isLodading = false;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Stack(
          children: [
            isLodading
                ? const Center(child: CircularProgressIndicator())
                : songs.isEmpty
                ? const Center(child: Text("No songs found"))
                : Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            margin: const EdgeInsets.all(12),
                            child: QueryArtworkWidget(
                              id: widget.albumId,
                              type: ArtworkType.ALBUM,
                              artworkFit: BoxFit.cover,
                              artworkBorder: BorderRadius.all(
                                Radius.circular(0),
                              ),
                              nullArtworkWidget: Container(
                                width: 100,
                                height: 100,
                                color: mainColors[5],
                                child: const Icon(Icons.album, size: 50),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  songs.first.album ?? "Unknown Album",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyles[4],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  songs.first.artist ?? "Unknown Artist",
                                  style: textStyles[1],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "${songs.length} Tracks",
                                  style: textStyles[2],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  getTotalDuration(songs),
                                  style: textStyles[2],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.separated(
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
                                artworkBorder: BorderRadius.all(
                                  Radius.circular(0),
                                ),
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
                      ),
                    ],
                  ),
          ],
        ),
        bottomNavigationBar: ValueListenableBuilder<SongModel?>(
          valueListenable: playerManager.currentSongNotifier,
          builder: (context, song, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: song == null ? const SizedBox() : MiniPlayer(song: song),
            );
          },
        ),
      ),
    );
  }
}
