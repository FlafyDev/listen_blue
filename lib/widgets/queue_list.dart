import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:music_player/logic/media_folders.dart';
import 'package:music_player/logic/player.dart';
import 'package:music_player/models/media.dart';
import 'package:music_player/widgets/media_horizontal_card.dart';
import 'media_list.dart';

class QueueList extends HookConsumerWidget {
  const QueueList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queue = ref.watch(
      musicPlayerProvider.select((player) => player.queue),
    );

    return ListView.builder(
      itemCount: queue.length,
      itemBuilder: (context, index) {
        final media = queue[index];
        return MediaTile(
          media: media,
          active: index == 0,
          onPressed: () {
            // ref.read(musicPlayerProvider.notifier).playQueue(media);
          },
        );
      },
    );
  }
}
