import 'homepage.dart';
import 'gameplay.dart';
import 'levelpage.dart';
import 'settingpage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ThinkerMan Flutter',
      home: HomePage(),
      routes: {
        '/game': (context) => GamePage(),
        '/settings': (context) => SettingsPage(),
        '/level': (context) => LevelPage(),
      },
    );
  }
}
