import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';

final OnAudioQuery audioQuery = OnAudioQuery();

// Classes

// Singleton Audio Player Manager
class AudioPlayerManager {
  static final AudioPlayerManager _instance = AudioPlayerManager._internal();
  factory AudioPlayerManager() => _instance;

  AudioPlayerManager._internal() {
    player.setAutomaticallyWaitsToMinimizeStalling(true);
  }

  final AudioPlayer player = AudioPlayer();
  ConcatenatingAudioSource songsQueue = ConcatenatingAudioSource(children: []);
  int currentSongIndex = 0;

  final ValueNotifier<SongModel?> currentSongNotifier =
      ValueNotifier<SongModel?>(null);

  void init() {
    player.currentIndexStream.listen((index) {
      if (index == null) return;
      final source = player.sequence[index] as UriAudioSource;
      final song = source.tag as SongModel;
      currentSongNotifier.value = song;
    });
  }

  Future<void> playSongs(List<SongModel> songs, int startIndex) async {
    currentSongIndex = startIndex;

    songsQueue = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: songs.map((song) {
        return AudioSource.uri(Uri.parse(song.uri!), tag: song);
      }).toList(),
    );
    await player.setAudioSource(songsQueue, initialIndex: startIndex);
    currentSongNotifier.value = songs[startIndex];
    await player.play();
  }

  Stream<Duration> get positionStream => player.positionStream;
  Stream<Duration?> get durationStream => player.durationStream;
}

// Artist with up to 4 album IDs for the 2×2 grid
class ArtistWithAlbums {
  final ArtistModel artist;
  final List<int> albumIds; // up to 4, used for the 2×2 grid

  const ArtistWithAlbums({required this.artist, required this.albumIds});
}

// Ask for permissions and load songs
Future<List<SongModel>> loadSongs() async {
  var status = await Permission.audio.request();

  if (status.isGranted) {
    List<SongModel> songs = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: SongSortType.TITLE,
      uriType: UriType.EXTERNAL,
    );

    return songs;
  }
  return [];
}

// Ask permissions and load albums
Future<List<AlbumModel>> loadAlbums() async {
  var status = await Permission.audio.request();

  if (status.isGranted) {
    List<AlbumModel> albums = await audioQuery.queryAlbums(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: AlbumSortType.ALBUM,
      uriType: UriType.EXTERNAL,
    );

    return albums;
  }
  return [];
}

// Ask permissions and load songs from an album
Future<List<SongModel>> loadAlbumtracks(int albumId) async {
  var status = await Permission.audio.request();

  if (status.isGranted) {
    List<SongModel> albumTracks = await audioQuery.queryAudiosFrom(
      AudiosFromType.ALBUM_ID,
      albumId,
      ignoreCase: true,
      orderType: null,
    );

    albumTracks.sort((a, b) {
      final trackA = a.track ?? 0;
      final trackB = b.track ?? 0;

      if (trackA != trackB) {
        return trackA.compareTo(trackB);
      }

      // fallback si hay tracks iguales o null
      return a.title.compareTo(b.title);
    });

    return albumTracks;
  }
  return [];
}

Future<List<ArtistWithAlbums>> loadArtists() async {
  final OnAudioQuery audioQuery = OnAudioQuery();

  final artists = await audioQuery.queryArtists(
    sortType: ArtistSortType.ARTIST,
    orderType: OrderType.ASC_OR_SMALLER,
    uriType: UriType.EXTERNAL,
  );

  final albums = await audioQuery.queryAlbums(
    sortType: AlbumSortType.ARTIST, // groups albums by artist
    orderType: OrderType.ASC_OR_SMALLER,
    uriType: UriType.EXTERNAL,
  );

  // Build a map: artistName → list of album IDs
  final Map<String, List<int>> albumsByArtist = {};
  for (final album in albums) {
    final key = album.artist ?? 'Unknown Artist';
    albumsByArtist.putIfAbsent(key, () => []).add(album.id);
  }

  return artists.map((artist) {
    final ids = albumsByArtist[artist.artist] ?? [];
    return ArtistWithAlbums(
      artist: artist,
      albumIds: ids.take(4).toList(), // max 4 for the 2×2 grid
    );
  }).toList();
}

// Format duration from milliseconds to mm:ss
String formatDuration(int durationMs) {
  final duration = Duration(milliseconds: durationMs);
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds % 60;

  return "$minutes:${seconds.toString().padLeft(2, '0')}";
}

// Get total duration of a list of songs
String getTotalDuration(List<SongModel> songs) {
  int totalMillis = songs.fold(0, (sum, song) => sum + (song.duration ?? 0));

  final totalSeconds = totalMillis ~/ 1000;

  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;

  return "$minutes m $seconds s";
}
