import 'package:flute_music_player/flute_music_player.dart';
import 'dart:math';

MusicFinder audioPlayer;
List<Song> songs;
var isPlaying = false;
var indexbackup;
var isPaused = false;
var isStopped = true;
Song currentSong;
Song previousSong;
Song nextSong;

Future play(String url) async {
  audioPlayer.play(url, isLocal: true);
  isPlaying = true;
  isStopped = false;
}

pause() async {
  audioPlayer.pause();
  isPlaying = false;
  isPaused = true;
  isStopped = false;
}

stop() async {
  audioPlayer.stop();
  isStopped = true;
}

class Data {
  List<Song> _songs;
  int _currentSongIndex = -1;
  MusicFinder musicFinder;
  Data(this._songs) {
    musicFinder = new MusicFinder();
  }

  List<Song> get songs => _songs;
  int get length => _songs.length;
  int get songNumber => _currentSongIndex + 1;

  setCurrentIndex(int index) {
    _currentSongIndex = index;
  }

  int get currentIndex => _currentSongIndex;

  Song get nextSong {
    if (_currentSongIndex < length) {
      _currentSongIndex++;
    }
    if (_currentSongIndex >= length) return null;
    return _songs[_currentSongIndex];
  }

  Song get randomSong {
    Random r = new Random();
    return _songs[r.nextInt(_songs.length)];
  }

  Song get prevSong {
    if (_currentSongIndex > 0) {
      _currentSongIndex--;
    }
    if (_currentSongIndex < 0) return null;
    return _songs[_currentSongIndex];
  }
}

