import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:music_player/logic/player.dart';

final activeTabIndexProvider = Provider((ref) => 0);

class TopBar extends HookConsumerWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 4);
    final theme = Theme.of(context);
    final activeIndex = ref.watch(activeTabIndexProvider);

    return Container(
      height: 100,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: tabController.animation!,
            builder: (context, child) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                        List.generate(tabController.length, (i) => i).map((i) {
                      double colorValue = 0;
                      double progress = tabController.offset != 0
                          ? (tabController.offset /
                                  (tabController.index -
                                      tabController.previousIndex))
                              .abs()
                          : 0;
                      if (tabController.index == i) {
                        colorValue = 1 - progress;
                      } else if (tabController.previousIndex == i) {
                        colorValue = progress;
                      }

                      return Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Color.lerp(
                              Colors.transparent,
                              Colors.white12,
                              colorValue,
                            ),
                            child: TextButton(
                              child: Icon(
                                color: Color.lerp(
                                  theme.colorScheme.secondary,
                                  theme.colorScheme.primary,
                                  colorValue,
                                ),
                                FontAwesomeIcons.list,
                                size: 18,
                              ),
                              onPressed: () => tabController.animateTo(i),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
          Container(
            height: 50,
            child: TabBarView(
              controller: tabController,
              children: [
                const Text("AAA"),
                const Text("BBB"),
                const Text("BBB"),
                const Text("BBB"),
              ],
            ),
          )
        ],
      ),
      // child: TabBar(
      //   controller: tabController,
      //   splashBorderRadius: BorderRadius.circular(5),
      //   tabs: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Icon(Icons.playlist_play),
      //     ),
      //     Icon(Icons.playlist_play),
      //   ],
      // ),
      // child: Row(
      //   children: [
      //     _TopButton(
      //       active: false,
      //       child: Icon(Icons.playlist_add),
      //       onPressed: () {},
      //     )
      //   ],
      // ),
    );
  }
}

class _TopButton extends StatelessWidget {
  final bool active;
  final Widget child;
  final VoidCallback? onPressed;

  const _TopButton({
    Key? key,
    required this.child,
    required this.active,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: onPressed,
            child: child,
          ),
        ),
      ],
    );
  }
}
