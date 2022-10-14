import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:music_player/models/playlist.dart';
import 'package:path/path.dart' as path;
import 'package:toml/toml.dart';

final String _folder = path.joinAll(
    [Platform.environment['HOME'] as String, ".config", "music_player"]);

final _configDataProvider = StreamProvider<Map<String, dynamic>>((ref) async* {
  final file = File(path.joinAll([_folder, "config.toml"]));

  if (!await file.exists()) {
    await file.create(recursive: true);
  }

  yield TomlDocument.parse(await file.readAsString()).toMap();
  await for (final event in file.parent.watch(events: FileSystemEvent.all)) {
    if (event is FileSystemModifyEvent || event is FileSystemCreateEvent) {
      yield TomlDocument.parse(await file.readAsString()).toMap();
    }
  }
});

final mediaFoldersProvider = Provider<List<Directory>>((ref) {
  final data = ref.watch(_configDataProvider).value;
  return data != null && data.containsKey("media")
      ? (data["media"] as List)
          .map((media) => Directory((media as String).replaceFirst(RegExp("^~"), Platform.environment["HOME"] as String)))
          .toList()
      : [];
});

final playlistsProvider = FutureProvider((ref) {
  final data = ref.watch(_configDataProvider);

  final completer = Completer<List<Playlist>>();
  data.whenData((data) {
    completer.complete((data["playlists"] as List)
        .map((e) => Playlist(
              title: e["title"],
              ids: (e["ids"] as List).whereType<String>().toList(),
              squareImage: e["squareImage"] == null
                  ? null
                  : FileImage(File(path.join(_folder, e["squareImage"]))),
            ))
        .toList());
  });

  return completer.future;
});
