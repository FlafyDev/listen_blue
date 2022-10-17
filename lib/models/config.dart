import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as path;
import 'playlist.dart';

part 'config.freezed.dart';

@freezed
class Config with _$Config {
  const factory Config({
    required Color? backgroundColor,
    required Color? primaryColor,
    required List<Playlist> playlists,
    required List<Directory> mediaDirectories,
  }) = _Config;

  factory Config.fromJson(Map<String, Object?> json, String configPath) {
    return Config(
      backgroundColor: Color((json["background_color"] as int?) ?? 0),
      primaryColor: json.containsKey("primary_color")
          ? Color(json["primary_color"] as int)
          : null,
      playlists: json.containsKey("playlists")
          ? (json["playlists"] as List)
              .map((e) => Playlist(
                    title: e["title"],
                    ids: (e["ids"] as List).whereType<String>().toList(),
                    squareImage: e["squareImage"] == null
                        ? null
                        : FileImage(File(
                            path.join(configPath, e["squareImage"]),
                          )),
                  ))
              .toList()
          : [],
      mediaDirectories: json.containsKey("collections")
          ? (json["collections"] as List)
              .map((media) => Directory((media as String).replaceFirst(
                  RegExp("^~"), Platform.environment["HOME"] as String)))
              .toList()
          : [],
    );
  }
}
