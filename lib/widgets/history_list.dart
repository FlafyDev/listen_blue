import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:listen_blue/logic/player.dart';
import 'media_list.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';

class HistoryList extends HookConsumerWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    final history = ref.watch(
      musicPlayerProvider.select((player) => player.history),
    );
    final queue = ref.watch(
      musicPlayerProvider.select((player) => player.queue),
    );

    return ImprovedScrolling(
      scrollController: scrollController,
      enableCustomMouseWheelScrolling: true,
      child: ListView.builder(
        controller: scrollController,
        itemCount: history.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final media = history[history.length - index - 1];
          return MediaTile(
            media: media,
            active: queue.isNotEmpty ? queue.first.id == media.id : false,
            onPressed: () {
              ref.read(musicPlayerProvider.notifier).addToTopQueue(media);
            },
            onLongPressed: () {
              ref.read(musicPlayerProvider.notifier).addToQueue(media);
            },
          );
        },
      ),
    );
  }
}
