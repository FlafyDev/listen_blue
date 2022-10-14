import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist.freezed.dart';

@freezed
class Playlist with _$Playlist {
  const factory Playlist({
    required List<String> ids,
    required String title,
    @Default(null) ImageProvider? squareImage,
  }) = _Playlist;
}
