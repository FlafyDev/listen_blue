import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:listen_blue/logic/config.dart';
import 'package:listen_blue/widgets/player_bar.dart';
import 'widgets/main_view.dart';

void main() {
  // timeDilation = 3.0;
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ColorScheme.fromSwatch().copyWith(
      // primary: const Color.fromARGB(255, 77, 112, 183),
      // primary: const Color.fromARGB(255, 126, 187, 229),
      primary: const Color.fromARGB(255, 82, 175, 234),
      secondary: const Color.fromARGB(255, 248, 206, 196),
    );

    final config = ref.watch(configDataProvider);

    useEffect(
      () {
        Window.setEffect(effect: WindowEffect.transparent);
        return () {};
      },
      [],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: colorScheme.primary,
          linearTrackColor: Colors.white10,
        ),
        colorScheme: colorScheme,
        toggleableActiveColor: const Color.fromARGB(255, 180, 120, 214),
        iconTheme: IconThemeData(color: colorScheme.secondary),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(),
          bodyMedium: TextStyle(),
          bodySmall: TextStyle(),
        ).apply(
          displayColor: colorScheme.secondary,
          bodyColor: colorScheme.secondary,
        ),
        shadowColor: const Color.fromARGB(30, 31, 47, 67),
      ),
      home: Scaffold(
        body: Container(
          // color: Color.fromARGB(255, 35, 37, 48),
          color: Color((config.value?["background_color"] as int?) ?? 0),
          child: Column(
            children: const [
              Expanded(child: MainView()),
              PlayerBar(),
            ],
          ),
        ),
      ),
    );
  }
}
