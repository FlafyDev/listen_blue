import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:music_player/logic/media_folders.dart';
import 'package:music_player/models/media.dart';
import 'history_list.dart';
import 'media_list.dart';
import 'playlist_list.dart';
import 'queue_list.dart';
import 'top_bar.dart';

class CustomTabBarViewScrollPhysics extends ScrollPhysics {
  const CustomTabBarViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomTabBarViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomTabBarViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 5000,
        stiffness: 100,
        damping: 0.8,
      );
}

class MainView extends HookConsumerWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 4);

    return Container(
      // height: 150,
      // color: Colors.red,
      child: Column(
        children: [
          TopBar(tabController: tabController),
          // TabBar(controller: tabController, tabs: [
          //   const Text("1"),
          //   const Text("2"),
          //   const Text("3"),
          //   const Text("4"),
          // ]),
          Expanded(
            child: Container(
              child: TabBarView(
                controller: tabController,
                // physics: CustomTabBarViewScrollPhysics(),
                physics: const BouncingScrollPhysics(),
                children: const [
                  MediaList(),
                  PlaylistList(),
                  QueueList(),
                  HistoryList(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
