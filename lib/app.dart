import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'pages/about_page.dart';

class SkywaterApp extends StatefulWidget {
  const SkywaterApp({super.key});

  @override
  State<SkywaterApp> createState() => _SkywaterAppState();

  // 靜態方法來更改語言
  static void setLocale(BuildContext context, Locale locale) {
    _SkywaterAppState? state =
        context.findAncestorStateOfType<_SkywaterAppState>();
    state?.setLocale(locale);
  }
}

class _SkywaterAppState extends State<SkywaterApp> {
  int _currentIndex = 0;
  Locale _locale = const Locale('en', 'US'); // 預設語言為英文

  final List<Widget> _pages = [HomePage(), SettingsPage(), AboutPage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skywater',
      locale: _locale, // 使用當前語言
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        // 若使用者語言在支援清單中，就使用；否則預設英文
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return const Locale('en');
      },
      home: Builder(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.appTitle),
              ),
              body: _pages[_currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: AppLocalizations.of(context)!.home,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.settings),
                    label: AppLocalizations.of(context)!.settings,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.info),
                    label: AppLocalizations.of(context)!.about,
                  ),
                ],
              ),
            ),
      ),
    );
  }

  // 更改語言後更新 _locale
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
}
