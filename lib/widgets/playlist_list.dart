import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:music_player/logic/media_folders.dart';
import 'package:music_player/logic/player.dart';
import 'package:music_player/logic/config.dart';
import 'package:music_player/models/media.dart';
import 'package:music_player/models/playlist.dart';

class PlaylistList extends HookConsumerWidget {
  const PlaylistList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaInfo = ref.watch(mediaInfoProvider);
    final playlists = ref.watch(playlistsProvider);

    return playlists.when(
      error: (err, trace) => const Text("Error"),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (playlists) => ListView.builder(
        itemCount: playlists.length,
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
          backgroundColor: Colors.black12,
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
