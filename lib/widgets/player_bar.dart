import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:listen_blue/logic/player.dart';
import 'package:listen_blue/widgets/media_horizontal_card.dart';

class PlayerBar extends HookConsumerWidget {
  const PlayerBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final player = ref.watch(musicPlayerProvider);
    final progress = ref.watch(musicPlayerProgressProvider);

    return Container(
      height: 80,
      color: theme.shadowColor,
      child: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 3,
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${player.passed.inMinutes}:${(player.passed.inSeconds % 60).toString().padLeft(2, "0")}",
                          ),
                          Text(
                            "${player.length.inMinutes}:${(player.length.inSeconds % 60).toString().padLeft(2, "0")}",
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Opacity(
                                  opacity: 0.7,
                                  child: _PressableIcon(
                                    onTap: () {
                                      ref
                                          .read(musicPlayerProvider.notifier)
                                          .togglePlay();
                                    },
                                    child: Icon(
                                      player.playing
                                          ? FontAwesomeIcons.pause
                                          : FontAwesomeIcons.play,
                                      size: 30,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                _PressableIcon(
                                  onTap: () {
                                    ref
                                        .read(musicPlayerProvider.notifier)
                                        .nextInQueue();
                                  },
                                  child: const Icon(
                                      FontAwesomeIcons.forwardStep,
                                      size: 20),
                                ),
                                const SizedBox(width: 10),
                                _PressableIcon(
                                  onTap: () {
                                    ref
                                        .read(musicPlayerProvider.notifier)
                                        .toggleShuffle();
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.shuffle,
                                    color: player.shuffle
                                        ? theme.toggleableActiveColor
                                        : null,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                _PressableIcon(
                                  onTap: () {
                                    ref
                                        .read(musicPlayerProvider.notifier)
                                        .toggleLoop();
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.repeat,
                                    size: 18,
                                    color: player.loop
                                        ? theme.toggleableActiveColor
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 50),
                          // Spacer(),
                          if (player.queue.isNotEmpty)
                            Flexible(
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 300),
                                child: MediaHorizontalCard(
                                  media: player.queue.first,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Opacity(
                opacity: 0,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 20,
                    overlayColor: Colors.transparent,
                    activeTrackColor: Colors.transparent,
                    inactiveTrackColor: Colors.transparent,
                    thumbColor: Colors.transparent,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 0.0),
                    trackShape: const RectangularSliderTrackShape(),
                    overlayShape: SliderComponentShape.noThumb,
                  ),
                  child: Slider(
                    onChanged: (value) {
                      ref.read(musicPlayerProvider.notifier).seek(Duration(
                          milliseconds:
                              (value * player.length.inMilliseconds).round()));
                    },
                    value: progress,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PressableIcon extends StatelessWidget {
  const _PressableIcon({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: child,
      ),
    );
  }
}
