import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:music_player/logic/media_folders.dart';
import 'package:music_player/logic/player.dart';
import 'package:music_player/models/media.dart';
import 'package:music_player/widgets/media_horizontal_card.dart';
import 'media_list.dart';

class HistoryList extends HookConsumerWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(
      musicPlayerProvider.select((player) => player.history),
    );
    final queue = ref.watch(
      musicPlayerProvider.select((player) => player.queue),
    );

    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        final media = history[history.length - index - 1];
        return MediaTile(
          media: media,
          active: queue.isNotEmpty
              ? queue.first.id == media.id
              : false,
          onPressed: () {
            ref.read(musicPlayerProvider.notifier).playQueue([media]);
          },
        );
      },
    );
  }
}
