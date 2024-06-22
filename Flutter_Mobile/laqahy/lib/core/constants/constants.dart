import 'package:audioplayers/audioplayers.dart';

class Constants {
  AudioPlayer audioPlayer = AudioPlayer();

  successAudio() {
    audioPlayer.play(AssetSource('sounds/success.mp3'));
  }

  errorAudio() {
    // audioPlayer.play(AssetSource('sounds/joke-error.m4a'));
    audioPlayer.play(AssetSource('sounds/error.mp3'));
  }
}
