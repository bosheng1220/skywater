import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:skywater/app.dart';
import '../l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.settingsDescription), // 顯示設定頁描述
            // 切換語言的按鈕
            ElevatedButton(
              onPressed: () {
                // 設置語言為中文
                _changeLanguage(context, Locale('zh', 'TW'));
              },
              child: Text(AppLocalizations.of(context)!.chinese),
            ),
            ElevatedButton(
              onPressed: () {
                // 設置語言為英文
                _changeLanguage(context, Locale('en', 'US'));
              },
              child: Text(AppLocalizations.of(context)!.english),
            ),
            ElevatedButton(
              onPressed: () {
                SkywaterApp.setLocale(context, const Locale('ja', 'JP'));
              },
              child: Text(AppLocalizations.of(context)!.japanese),
            ),
          ],
        ),
      ),
    );
  }

  // 切換語言的邏輯
  void _changeLanguage(BuildContext context, Locale locale) {
    Locale myLocale = locale;
    // 更新應用語言
    SkywaterApp.setLocale(context, myLocale);
  }
}
