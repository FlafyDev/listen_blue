import 'package:flutter/material.dart';
import 'package:music_player/models/media.dart';

class MediaHorizontalCard extends StatelessWidget {
  const MediaHorizontalCard({Key? key, required this.media, this.color})
      : super(key: key);

  final PlayableMedia media;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        if (media.metadata.squareImage != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image(
              image: media.metadata.squareImage!,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.medium,
            ),
          ),
        const SizedBox(width: 10, height: 40),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                media.metadata.title,
                style: theme.textTheme.bodyLarge?.apply(color: color),
                overflow: TextOverflow.clip,
                softWrap: false,
                maxLines: 1,
              ),
              Text(
                media.metadata.authors.join(", "),
                style: theme.textTheme.bodySmall?.apply(color: color),
                overflow: TextOverflow.clip,
                softWrap: false,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
