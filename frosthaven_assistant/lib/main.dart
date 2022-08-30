import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frosthaven_assistant/Layout/theme.dart';
import 'package:frosthaven_assistant/Resource/settings.dart';
import 'package:frosthaven_assistant/main_state.dart';
import 'package:frosthaven_assistant/services/service_locator.dart';

import 'package:wakelock/wakelock.dart';
import 'package:window_size/window_size.dart';

import 'Resource/theme_switcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('X-haven Assistant');
    setWindowMinSize(const Size(400, 600));
    setWindowMaxSize(Size.infinite);
  }

  runApp(
    ThemeSwitcherWidget(initialTheme: theme, child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

     //call after keyboard
    if (Platform.isIOS || Platform.isAndroid) {
      Wakelock.enable();
      //should force app to be in foreground and disable screen lock
    }
    //Screen.keepOn(true);

    getIt<Settings>().init();

    //getIt<Settings>().setFullscreen(true);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //debugShowMaterialGrid: true,
        checkerboardOffscreenLayers: false,
        //showPerformanceOverlay: true,
        title: 'X-haven Assistant',
        theme: ThemeSwitcher.of(context).themeData,
        home: const MyHomePage(title: 'X-haven Assistant'),
      );

  }


}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => MainState();
}
