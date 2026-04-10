import 'package:flutter/material.dart';
import 'package:local_tunes/Methods/methods.dart';
import 'package:local_tunes/Theme/theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({super.key});

  @override
  State<ArtistsPage> createState() => ArtistsPageState();
}

class ArtistsPageState extends State<ArtistsPage> {
  final AudioPlayerManager playerManager = AudioPlayerManager();
  List<ArtistWithAlbums> artists = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    () async {
      var list = await loadArtists();
      setState(() {
        artists = list;
        isLoading = false;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : artists.isEmpty
              ? const Center(child: Text("No artists found"))
              : ListView.separated(
                  itemCount: artists.length,
                  separatorBuilder: (context, index) => Container(
                    height: 0.8,
                    color: mainColors[3],
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                  itemBuilder: (context, index) {
                    final item = artists[index];
                    return ListTile(
                      onTap: () {
                        // TODO: Navigator.push to ArtistTracksPage
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      // 2×2 album art grid
                      leading: StackedAlbumArt(albumIds: item.albumIds),

                      // Artist name
                      title: Text(
                        item.artist.artist,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles[1],
                      ),

                      // Album + track counts
                      subtitle: Text(
                        "${item.artist.numberOfAlbums ?? 0} albums, ${item.artist.numberOfTracks ?? 0} tracks ",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyles[2],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

class StackedAlbumArt extends StatelessWidget {
  final List<int> albumIds;

  const StackedAlbumArt({super.key, required this.albumIds});

  @override
  Widget build(BuildContext context) {
    const double artSize = 46.0; // size of each individual artwork square
    const double step = 8.0; // diagonal offset between each layer

    final count = albumIds.length.clamp(1, 3);

    // Total canvas size grows with each extra layer
    final double canvasSize = artSize + step * (count - 1);

    Widget artwork(int id) {
      return QueryArtworkWidget(
        id: id,
        type: ArtworkType.ALBUM,
        artworkWidth: artSize,
        artworkHeight: artSize,
        artworkFit: BoxFit.cover,
        artworkBorder: BorderRadius.zero,
        nullArtworkWidget: Container(
          width: artSize,
          height: artSize,
          color: mainColors[5],
          child: const Icon(Icons.music_note, size: 18),
        ),
      );
    }

    Widget fallback() => Container(
      width: artSize,
      height: artSize,
      color: mainColors[5],
      child: const Icon(Icons.music_note, size: 18),
    );

    return SizedBox(
      width: canvasSize,
      height: canvasSize,
      child: Stack(
        children: List.generate(count, (i) {
          // i=0 is the backmost layer, i=count-1 is the front
          final offset = step * i;
          final id = albumIds[i];
          return Positioned(
            left: offset,
            top: offset,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: mainColors[0],
                    blurRadius: 4,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
              child: id >= 0 ? artwork(id) : fallback(),
            ),
          );
        }),
      ),
    );
  }
}
