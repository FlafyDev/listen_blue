import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:music_player/models/media.dart';
import 'package:path/path.dart' as path;
import 'package:toml/toml.dart';

import 'config.dart';

final mediaInfoProvider = Provider((ref) {
  final collections = ref.watch(mediaCollectionsProvider);
  final mediaInfo = <String, LocalMedia>{};
  for (final collection in collections.value ?? <MediaCollectionFile>[]) {
    collection.media.forEach((key, value) {
      mediaInfo[key] = value;
    });
  }

  return mediaInfo;
});

Future<MediaCollectionFile> _loadCollection(File collectionFile) async {
  return MediaCollectionFile(
    file: collectionFile,
    media: TomlDocument.parse(await collectionFile.readAsString())
        .toMap()
        .map((key, value) {
      return MapEntry(
        key,
        LocalMedia(
          id: key,
          file: File(path.join(collectionFile.parent.path, "$key.mp3")),
          metadata: MediaMetadata(
            title: value["title"] as String,
            authors:
                (value["authors"] as List?)?.whereType<String>().toList() ?? [],
            squareImage: value["squareImage"] == null
                ? null
                : FileImage(File(path.join(
                    collectionFile.parent.path, value["squareImage"]))),
          ),
        ),
      );
    }),
  );
}

final mediaCollectionsProvider = StreamProvider((ref) async* {
  final folders = ref.watch(mediaFoldersProvider);
  final collections = <MediaCollectionFile>[];
  yield collections;

  for (final folder in folders) {
    final File collectionFile = File(path.join(folder.path, "collection.toml"));
    collections.add(await _loadCollection(collectionFile));
  }

  yield collections;

  for (final folder in folders) {
    await for (final event in folder.watch(events: FileSystemEvent.all)) {
      if (event is FileSystemModifyEvent || event is FileSystemCreateEvent) {
        if (event.isDirectory ||
            path.basename(event.path) != "collection.toml") {
          continue;
        }

        final collection = await _loadCollection(File(event.path));

        collections.removeWhere(
            (element) => element.file.path == collection.file.path);
        collections.add(collection);
        yield collections;
      }
    }
  }
});
