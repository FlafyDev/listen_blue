import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:music_player/logic/player.dart';

class PlayerBar extends HookConsumerWidget {
  const PlayerBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final player = ref.watch(musicPlayerProvider);
    final progress = ref.watch(musicPlayerProgressProvider);

    return Container(
      height: 80,
      color: Colors.black12,
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
                          Container(
                            width: 200,
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(FontAwesomeIcons.backwardStep, size: 20),
                                SizedBox(width: 5),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: InkWell(
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
                                SizedBox(width: 5),
                                Icon(FontAwesomeIcons.forwardStep, size: 20),
                                SizedBox(width: 10),
                                Icon(FontAwesomeIcons.shuffle,
                                    size: 20,
                                    color: theme.toggleableActiveColor),
                                SizedBox(width: 10),
                                Icon(FontAwesomeIcons.repeat, size: 17),
                              ],
                            ),
                          ),
                          SizedBox(width: 50),
                          if (player.currentMedia != null)
                            Flexible(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4.0),
                                      child: Image(
                                        image: player
                                            .currentMedia!.metadata.squareImage,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.medium,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            player.currentMedia!.metadata.title,
                                            style: theme.textTheme.bodyLarge,
                                            overflow: TextOverflow.clip,
                                            softWrap: false,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            player
                                                .currentMedia!.metadata.authors
                                                .join(", "),
                                            style: theme.textTheme.bodySmall,
                                            overflow: TextOverflow.clip,
                                            softWrap: false,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
