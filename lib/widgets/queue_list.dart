import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:listen_blue/logic/player.dart';
import 'media_list.dart';

class QueueList extends HookConsumerWidget {
  const QueueList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final theme = Theme.of(context);

    final queue = ref.watch(
      musicPlayerProvider.select((player) => player.queue),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  ref.read(musicPlayerProvider.notifier).clearQueue();
                },
                child: Text(
                  "Clear",
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.read(musicPlayerProvider.notifier).shuffleQueue();
                },
                child: Icon(
                  FontAwesomeIcons.shuffle,
                  size: 15,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ImprovedScrolling(
            scrollController: scrollController,
            enableCustomMouseWheelScrolling: true,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: scrollController,
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
            ),
          ),
        ),
      ],
    );
  }
}
