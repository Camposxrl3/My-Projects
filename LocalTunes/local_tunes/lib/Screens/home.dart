import 'package:flutter/material.dart';
import 'package:local_tunes/Methods/methods.dart';
import 'package:local_tunes/Screens/mini_player.dart';
import 'package:local_tunes/Screens/albums.dart';
import 'package:local_tunes/Screens/artists.dart';
import 'package:local_tunes/Screens/playlists.dart';
import 'package:local_tunes/Screens/tracks.dart';
import 'package:local_tunes/Theme/theme.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final AudioPlayerManager playerManager = AudioPlayerManager();
  final String title = "LocalTunes";
  int currentIndex = 0;

  final List<String> screens = const [
    "Tracks",
    "Albums",
    "Artists",
    "Playlists",
  ];

  final List<Widget> icons = const [
    Icon(Icons.music_note),
    Icon(Icons.album),
    Icon(Icons.person),
    Icon(Icons.library_music),
  ];

  final List<Widget> screenWidgets = const [
    TracksPage(),
    AlbumsPage(),
    ArtistsPage(),
    PlaylistsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          child: screenWidgets[currentIndex],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<SongModel?>(
              valueListenable: playerManager.currentSongNotifier,
              builder: (context, song, child) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: song == null
                      ? const SizedBox()
                      : MiniPlayer(song: song),
                );
              },
            ),
            BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: List.generate(screens.length, (index) {
                return BottomNavigationBarItem(
                  backgroundColor: mainColors[3],
                  icon: icons[index],
                  label: screens[index],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
