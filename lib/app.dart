import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'pages/about_page.dart';

class SkywaterApp extends StatefulWidget {
  const SkywaterApp({super.key});

  @override
  State<SkywaterApp> createState() => _SkywaterAppState();
}

class _SkywaterAppState extends State<SkywaterApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SettingsPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skywater',
      home: Scaffold(
        appBar: AppBar(title: const Text('Skywater')),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: '關於'),
          ],
        ),
      ),
    );
  }
}
