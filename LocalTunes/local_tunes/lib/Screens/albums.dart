import 'package:flutter/material.dart';
import 'package:local_tunes/Methods/methods.dart';
import 'package:local_tunes/Screens/album_tracks.dart';
import 'package:local_tunes/Theme/theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => AlbumsPageState();
}

class AlbumsPageState extends State<AlbumsPage> {
  final AudioPlayerManager playerManager = AudioPlayerManager();
  List<AlbumModel> albums = [];
  bool isLodading = true;

  @override
  void initState() {
    super.initState();
    () async {
      var list = await loadAlbums();
      setState(() {
        albums = list;
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
              : albums.isEmpty
              ? const Center(child: Text("No songs found"))
              : ListView.separated(
                  itemCount: albums.length,
                  separatorBuilder: (context, index) => Container(
                    height: 0.8,
                    color: mainColors[3],
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  itemBuilder: (context, index) {
                    final album = albums[index];
                    return ListTile(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AlbumTracksPage(albumId: album.id),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      // Album artwork
                      leading: QueryArtworkWidget(
                        id: album.id,
                        type: ArtworkType.ALBUM,
                        artworkFit: BoxFit.cover,
                        artworkBorder: BorderRadius.all(Radius.circular(0)),
                        nullArtworkWidget: Container(
                          width: 50,
                          height: 50,
                          color: mainColors[5],
                          child: const Icon(Icons.music_note),
                        ),
                      ),

                      // Album Name + Artist Name
                      title: Text(
                        album.album,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles[1],
                      ),
                      subtitle: Text(
                        album.artist ?? "Unknown Artist",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles[2],
                      ),

                      // Album tracks quantity
                      trailing: Text(
                        "${album.numOfSongs} tracks",
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
