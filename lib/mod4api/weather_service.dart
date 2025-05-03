import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  // 從 .env 中取得 API 金鑰
  final String apiKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';

  Future<Map<String, dynamic>> fetchKaohsiungWeather() async {
    if (apiKey.isEmpty) {
      throw Exception('API 金鑰不存在，請確認 .env 設定');
    }

    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=Lingya,Kaohsiung,TW&appid=$apiKey&units=metric&lang=zh_tw',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('取得天氣資料失敗（狀態碼: ${response.statusCode}）');
    }
  }
}
