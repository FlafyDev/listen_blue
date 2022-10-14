import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media.freezed.dart';

class LocalMedia extends PlayableMedia {
  final File file;

  LocalMedia({
    required String id,
    required this.file,
    required MediaMetadata metadata,
  }) : super(id: id, metadata: metadata);
}

abstract class PlayableMedia {
  final String id;
  final MediaMetadata metadata;

  PlayableMedia({
    required this.id,
    required this.metadata,
  });
}

@freezed
class MediaCollectionFile with _$MediaCollectionFile {
  const factory MediaCollectionFile({
    required File file,
    required Map<String, LocalMedia> media,
  }) = _MediaCollectionFile;
}

// @freezed
// class MediaInfo with _$MediaInfo {
//   const factory MediaInfo({
//     required File mediaFile,
//     required MediaMetadata metadata,
//   }) = _MediaInfo;
// }

@freezed
class MediaMetadata with _$MediaMetadata {
  const factory MediaMetadata({
    required String title,
    required List<String> authors,
    ImageProvider? squareImage,
  }) = _MediaMetadata;

  factory MediaMetadata.fromJson(Map<String, Object?> json) {
    return MediaMetadata(
      title: json["title"] as String,
      authors: json["authors"] as List<String>,
      squareImage: json["squareImage"] == null ? null : FileImage(File(json["squareImage"] as String)),
    );
  }
}

@freezed
class MusicPlayer with _$MusicPlayer {
  const factory MusicPlayer({
    @Default(Duration.zero) Duration passed,
    @Default(Duration.zero) Duration length,
    // @Default(null) PlayableMedia? currentMedia,
    @Default([]) List<PlayableMedia> queue,
    @Default([]) List<PlayableMedia> history,
    @Default(false) bool playing,
    @Default(false) bool shuffle,
    @Default(false) bool loop,
  }) = _MusicPlayer;
}
