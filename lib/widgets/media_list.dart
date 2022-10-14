import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:music_player/logic/media_folders.dart';
import 'package:music_player/logic/player.dart';
import 'package:music_player/models/media.dart';
import 'package:music_player/widgets/media_horizontal_card.dart';

class MediaList extends HookConsumerWidget {
  const MediaList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    final mediaInfo = ref.watch(mediaInfoProvider);
    final queue = ref.watch(
      musicPlayerProvider.select((player) => player.queue),
    );

    return ImprovedScrolling(
      scrollController: scrollController,
      enableCustomMouseWheelScrolling: true,
      child: ListView.builder(
        controller: scrollController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: mediaInfo.keys.length,
        itemBuilder: (context, index) {
          final media = mediaInfo.values.toList()[index];
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

class MediaTile extends StatelessWidget {
  const MediaTile({
    Key? key,
    required this.media,
    this.active = false,
    required this.onPressed,
    this.onLongPressed,
  }) : super(key: key);

  final PlayableMedia media;
  final bool active;
  final VoidCallback onPressed;
  final VoidCallback? onLongPressed;

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: TextButton(
        onPressed: onPressed,
        onLongPress: onLongPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          backgroundColor: theme.shadowColor,
        ),
        child: MediaHorizontalCard(
          media: media,
          color: active ? theme.colorScheme.primary : null,
        ),
      ),
    );
  }
}
