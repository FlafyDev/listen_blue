import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:listen_blue/models/config.dart';
import 'package:path/path.dart' as path;
import 'package:toml/toml.dart';

final configPathProvider = Provider((ref) => path.joinAll(
    [Platform.environment['HOME'] as String, ".config", "listen_blue"]));

final configDataProvider = StreamProvider<Config>((ref) async* {
  final configPath = ref.watch(configPathProvider);
  final file = File(path.joinAll([configPath, "config.toml"]));

  if (!await file.exists()) {
    await file.create(recursive: true);
  }

  Future<Config> generateConfig() async {
    return Config.fromJson(
      TomlDocument.parse(await file.readAsString()).toMap(),
      configPath,
    );
  }

  yield await generateConfig();
  await for (final event in file.parent.watch(events: FileSystemEvent.all)) {
    if (event is FileSystemModifyEvent || event is FileSystemCreateEvent) {
      yield await generateConfig();
    }
  }
});

// final mediaFoldersProvider = Provider<List<Directory>>((ref) {
//   final data = ref.watch(configDataProvider).value;
//   return data != null && data.containsKey("collections")
//       ? (data["collections"] as List)
//           .map((media) => Directory((media as String).replaceFirst(
//               RegExp("^~"), Platform.environment["HOME"] as String)))
//           .toList()
//       : [];
// });

// final playlistsProvider = Provider<List<Playlist>>((ref) {
//   final data = ref.watch(configDataProvider).value;
//
//   return data != null && data.containsKey("playlists")
//       ? (data["playlists"] as List)
//           .map((e) => Playlist(
//                 title: e["title"],
//                 ids: (e["ids"] as List).whereType<String>().toList(),
//                 squareImage: e["squareImage"] == null
//                     ? null
//                     : FileImage(File(path.join(homePath, e["squareImage"]))),
//               ))
//           .toList()
//       : [];
// });
