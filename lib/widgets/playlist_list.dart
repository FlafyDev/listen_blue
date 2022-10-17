import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_improved_scrolling/flutter_improved_scrolling.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:listen_blue/logic/media_folders.dart';
import 'package:listen_blue/logic/player.dart';
import 'package:listen_blue/logic/config.dart';
import 'package:listen_blue/models/media.dart';
import 'package:listen_blue/models/playlist.dart';

class PlaylistList extends HookConsumerWidget {
  const PlaylistList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    final mediaInfo = ref.watch(mediaInfoProvider);
    final playlists = ref.watch(
      configDataProvider.select((config) => config.value?.playlists ?? []),
    );

    return ImprovedScrolling(
      scrollController: scrollController,
      enableCustomMouseWheelScrolling: true,
      child: ListView.builder(
        controller: scrollController,
        itemCount: playlists.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final playlist = playlists[index];
          return _PlaylistTile(
            playlist: playlist,
            active: false,
            onPressed: () {
              ref.read(musicPlayerProvider.notifier).playQueue(playlist.ids
                  .map((id) => mediaInfo[id])
                  .whereType<PlayableMedia>()
                  .toList());
            },
          );
        },
      ),
    );
  }
}

class _PlaylistTile extends StatelessWidget {
  const _PlaylistTile({
    Key? key,
    required this.playlist,
    this.active = false,
    required this.onPressed,
  }) : super(key: key);

  final Playlist playlist;
  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          backgroundColor: theme.shadowColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (playlist.squareImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image(
                  image: playlist.squareImage!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            Text(
              playlist.title,
              style: theme.textTheme.bodyLarge,
            ),
            Text(
              "${playlist.ids.length} track${playlist.ids.length == 1 ? "" : "s"}",
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
        // child: MediaHorizontalCard(
        //   media: ,
        //   color: active ? theme.colorScheme.primary: null,
        // ),
      ),
    );
  }
}
