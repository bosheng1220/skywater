import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'pages/about_page.dart';

class SkywaterApp extends StatelessWidget {
  const SkywaterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skywater',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}
