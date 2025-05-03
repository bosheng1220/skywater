import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skywater/app.dart'; // 或是 main.dart 裡的 MyApp/SkywaterApp

void main() {
  testWidgets('首頁顯示按鈕與標題', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SkywaterApp());

    // 驗證是否有標題 "首頁"
    expect(find.text('首頁'), findsOneWidget);

    // 驗證是否有兩個按鈕
    expect(find.text('前往設定頁'), findsOneWidget);
    expect(find.text('前往關於頁'), findsOneWidget);
  });
}
