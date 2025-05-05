import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
//純初始化
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
    print('✅ 成功加載 .env');
  } catch (e) {
    print('❌ 無法加載 .env 文件: $e');
  }

  runApp(SkywaterApp());
}

