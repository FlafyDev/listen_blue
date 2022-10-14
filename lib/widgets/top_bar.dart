import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopBar extends HookConsumerWidget {
  const TopBar({Key? key, required this.tabController}) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    const icons = [
      FontAwesomeIcons.music,
      FontAwesomeIcons.list,
      FontAwesomeIcons.stopwatch,
      FontAwesomeIcons.clockRotateLeft,
    ];

    return Column(
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
                              icons[i],
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
      ],
    );
  }
}
