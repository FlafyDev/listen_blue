import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:music_player/models/music_player.dart';
import 'package:audioplayers/audioplayers.dart';

final musicPlayerProgressProvider = Provider<double>((ref) {
  final player = ref.watch(musicPlayerProvider);
  return player.length.inMilliseconds == 0
      ? 0
      : player.passed.inMilliseconds / player.length.inMilliseconds;
});

final audioPlayerProvider = Provider.autoDispose((ref) {
  return AudioPlayer();
});

final musicPlayerProvider =
    StateNotifierProvider<MusicPlayerNotifier, MusicPlayer>(
  (ref) => MusicPlayerNotifier(ref.read(audioPlayerProvider)),
);

class MusicPlayerNotifier extends StateNotifier<MusicPlayer> {
  final AudioPlayer _audioPlayer;
  MusicPlayerNotifier(this._audioPlayer) : super(const MusicPlayer()) {
    _audioPlayer.onPositionChanged.listen((position) {
      state = state.copyWith(passed: position);
    });

    _audioPlayer.onPlayerStateChanged.listen((playingState) {
      state = state.copyWith(playing: playingState == PlayerState.playing);
      if (playingState == PlayerState.completed) {
        state = state.copyWith(
          passed: Duration.zero,
          length: Duration.zero,
          currentMedia: null,
        );
      }
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      state = state.copyWith(length: duration);
    });
  }

  Future<void> playMedia(PlayableMedia media) async {
    await _audioPlayer.stop();

    state = state.copyWith(currentMedia: media, passed: Duration.zero);
    if (media is LocalMedia) {
      await _audioPlayer.play(DeviceFileSource(media.file.path));
    }
  }

  FutureOr<void> togglePlay() {
    switch (_audioPlayer.state) {
      case PlayerState.playing:
        return _audioPlayer.pause();
      case PlayerState.paused:
        return _audioPlayer.resume();
      default:
        break;
    }
  }

  Future<void> seek(Duration position) {
    return _audioPlayer.seek(position);
  }
}


// final progressProvider = StreamProvider<Duration>((ref) {
//   final player = ref.watch(playerProvider);
//   return Stream.periodic(Duration(seconds: 1), (i) => player.position);
// });
//
// final currentMediaProvider = StateProvider<PlayableMedia?>(
//   (ref) => null,
//   // (ref) => LocalMedia(
//   //   file: File('/home/flafydev/Music/music.mp3'),
//   //   metadata: MediaMetadata(
//   //     title: "Dance in the Game [ORCHESTRAL]",
//   //     authors: ["Kikuin Date"],
//   //     squareImage: const NetworkImage(
//   //       "https://cdn.dribbble.com/users/702789/screenshots/16900790/media/628a8bb9f58f4feaea51367fc58b32a3.png?compress=1&resize=400x300",
//   //     ),
//   //   ),
//   // ),
// );

// Future<void> setMedia(PlayableMedia media) async {
//   switch (media) {
//   }
//   await player.stop();
//   ref.read(currentMediaProvider.state).state = media;
//   await player.setFilePath(media.file.path);
// }
//
