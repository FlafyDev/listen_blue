import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:listen_blue/models/media.dart';

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

    _audioPlayer.onPlayerStateChanged.listen((playingState) async {
      state = state.copyWith(playing: playingState == PlayerState.playing);
      if (playingState == PlayerState.completed) {
        if (state.loop) {
          await _play(state.queue.first);
        } else {
          await nextInQueue();
        }
      }
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      state = state.copyWith(length: duration);
    });
  }

  Future<void> stopAll() async {
    await _audioPlayer.stop();
    state = state.copyWith(
      passed: Duration.zero,
      length: Duration.zero,
      queue: [],
    );
  }

  Future<void> nextInQueue() async {
    if (state.queue.length <= 1) {
      return stopAll();
    }

    state = state.copyWith(queue: state.queue.sublist(1));
    return _play(state.queue.first);
  }

  Future<void> playQueue(List<PlayableMedia> queue) async {
    state = state.copyWith(queue: queue, passed: Duration.zero);
    if (queue.isEmpty) return stopAll();
    if (state.shuffle) await shuffleQueue();
    await _play(queue.first);
  }

  Future<void> addToTopQueue(PlayableMedia media) async {
    await playQueue([media, ...state.queue]);
  }

  Future<void> addToQueue(PlayableMedia media) async {
    state = state.copyWith(queue: [...state.queue, media]);
    if (state.queue.length == 1) {
      return _play(state.queue.first);
    }
  }

  void clearQueue() {
    state = state.copyWith(queue: [state.queue.first]);
  }

  Future<void> _play(PlayableMedia media) async {
    await _audioPlayer.stop();
    if (media is LocalMedia) {
      await _audioPlayer.play(DeviceFileSource(media.file.path));
    } else {
      throw Exception("Unplayable media");
    }
    state = state.copyWith(
      history: [...state.history, media],
    );
  }

  Future<void> shuffleQueue() async {
    if (state.queue.length <= 1) return;

    state = state.copyWith(queue: [
      state.queue.first,
      ...state.queue.sublist(1)..shuffle(),
    ]);
  }

  FutureOr<void> togglePlay() async {
    switch (_audioPlayer.state) {
      case PlayerState.playing:
        return _audioPlayer.pause();
      case PlayerState.paused:
        return _audioPlayer.resume();
      default:
        return;
    }
  }

  void toggleLoop() {
    state = state.copyWith(loop: !state.loop);
  }

  void toggleShuffle() {
    state = state.copyWith(shuffle: !state.shuffle);
    if (state.shuffle) {
      shuffleQueue();
    }
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
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
