import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'history_list.dart';
import 'media_list.dart';
import 'playlist_list.dart';
import 'queue_list.dart';
import 'top_bar.dart';

class MainView extends HookConsumerWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 4);

    return Column(
      children: [
        TopBar(tabController: tabController),
        Expanded(
          child: TabBarView(
            controller: tabController,
            physics: const BouncingScrollPhysics(),
            children: const [
              MediaList(),
              PlaylistList(),
              QueueList(),
              HistoryList(),
            ],
          ),
        )
      ],
    );
  }
}
