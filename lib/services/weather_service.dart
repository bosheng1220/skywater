import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  final String apiKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';

  Future<Map<String, dynamic>> fetchWeather(String cityName) async {
    if (apiKey.isEmpty) {
      throw Exception('API 金鑰不存在，請確認 .env 設定');
    }

    // 將城市名稱轉換為英文拼音
    String city = _convertToPinyin(cityName);

    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=zh_tw',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('取得天氣資料失敗（狀態碼: ${response.statusCode}）');
    }
  }

  String _convertToPinyin(String cityName) {
    // 這裡我們用一個簡單的映射將中文城市轉換為拼音或英文
    const cityMap = {
      '台南': 'Tainan',
      '台北': 'Taipei',
      '高雄': 'Kaohsiung',
      '台中': 'Taichung',
      '新竹': 'Hsinchu',
      // 可以在這裡加入更多城市的映射
    };

    return cityMap[cityName] ?? cityName; // 如果沒有映射，使用原始城市名稱
  }
}
