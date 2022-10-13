import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.freezed.dart';

class LocalMedia extends PlayableMedia {
  final File file;

  LocalMedia({
    required MediaMetadata metadata,
    required this.file,
  }) : super(metadata: metadata);
}

abstract class PlayableMedia {
  final MediaMetadata metadata;

  PlayableMedia({
    required this.metadata,
  });
}

@freezed
class MediaMetadata with _$MediaMetadata {
  const factory MediaMetadata({
    required String title,
    required List<String> authors,
    required ImageProvider squareImage,
  }) = _MediaMetadata;
}

@freezed
class MusicPlayer with _$MusicPlayer {
  const factory MusicPlayer({
    @Default(Duration.zero) Duration passed,
    @Default(Duration.zero) Duration length,
    @Default(null) PlayableMedia? currentMedia,
    @Default(false) bool playing,
    @Default(false) bool shuffle,
    @Default(false) bool loop,
  }) = _MusicPlayer;
}
