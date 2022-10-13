import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/logic/player.dart';
import 'package:music_player/widgets/player_bar.dart';

import 'models/music_player.dart';
import 'widgets/top_bar.dart';

void main() {
  // timeDilation = 3.0;
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ColorScheme.fromSwatch().copyWith(
      primary: const Color.fromARGB(255, 37, 137, 144),
      secondary: const Color.fromARGB(255, 248, 206, 196),
    );
    final player = ref.watch(musicPlayerProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: colorScheme.primary,
          linearTrackColor: Colors.white10,
        ),
        colorScheme: colorScheme,
        toggleableActiveColor: Color.fromARGB(255, 180, 120, 214),
        iconTheme: IconThemeData(color: colorScheme.secondary),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(),
          bodyMedium: TextStyle(),
          bodySmall: TextStyle(),
        ).apply(
          displayColor: colorScheme.secondary,
          bodyColor: colorScheme.secondary,
        ),
      ),
      home: Scaffold(
        body: Container(
          color: Color.fromARGB(255, 35, 37, 48),
          child: Column(
            children: [
              TopBar(),
              Spacer(),
              Container(
                height: 100,
                child: TextButton(
                  child: Text("AAA"),
                  onPressed: () async {
                    final LocalMedia media = LocalMedia(
                      file: File('/home/flafydev/Music/music.mp3'),
                      metadata: MediaMetadata(
                        title: "Dance in the Game [ORCHESTRAL]",
                        authors: ["Kikuin Date"],
                        squareImage: const NetworkImage(
                          "https://cdn.dribbble.com/users/702789/screenshots/16900790/media/628a8bb9f58f4feaea51367fc58b32a3.png?compress=1&resize=400x300",
                        ),
                      ),
                    );
                    ref.read(musicPlayerProvider.notifier).playMedia(media);
                     // final player = aa.AudioPlayer();
                     // player.play(aa.DeviceFileSource("/home/flafydev/Music/music.mp3"));
                     // player.onPositionChanged.listen((pos) => print(pos));
                    // final duration =
                    //     await player.setFilePath('/home/flafydev/Music/music.mp3');
                    // print(duration);
                  },
                ),
              ),
              Container(child: PlayerBar()),
            ],
          ),
        ),
      ),
    );
  }
}
