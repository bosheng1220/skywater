//config管理或是用dotenv可能更簡便
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get weatherApiKey =>
      dotenv.get('OPENWEATHER_API_KEY', fallback: '');

  static String get apiBaseUrl =>
      dotenv.get('API_BASE_URL', fallback: 'https://api.openweathermap.org');
}
