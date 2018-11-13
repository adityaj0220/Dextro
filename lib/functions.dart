import 'package:flute_music_player/flute_music_player.dart';

MusicFinder audioPlayer;
List<Song> songs;
var isPlaying = false;
var indexbackup;
var isPaused = false;
var isStopped = true;
Song currentSong;

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

