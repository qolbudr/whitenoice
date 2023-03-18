import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  final _player = AudioPlayer(handleInterruptions: false, handleAudioSessionActivation: false, androidApplyAudioAttributes: false);

  AudioPlayerHandler() {
    _player.setLoopMode(LoopMode.one);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {
    if(_player.playing) await _player.stop();
    await _player.setAsset(mediaItem.id);
    play();
  }

  @override
  Future<void> stop() => _player.stop();
}