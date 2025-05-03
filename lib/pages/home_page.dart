import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('首頁')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              child: const Text('前往設定頁'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/about'),
              child: const Text('前往關於頁'),
            ),
          ],
        ),
      ),
    );
  }
}
