import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlacesService {
  final String apiKey = dotenv.env['YOUR_GOOGLE_PLACES_API_KEY'] ?? '';

  Future<String?> getEnglishCity(String input) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=en&types=(cities)&key=$apiKey',
    );

    final response = await http.get(url);

    print('🔍 請求網址: $url');
    print('📦 回傳原始資料: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK' && data['predictions'].isNotEmpty) {
        final terms = data['predictions'][0]['terms'];
        if (terms != null && terms.length >= 2) {
          final city = terms[1]['value']; // index 1 是城市
          print('✅ 使用 Google Places 取得英文城市: $city');
          return city;
        } else {
          print('⚠️ 預測結果中找不到城市名稱');
          return null;
        }
      } else {
        print('⚠️ 沒有找到建議結果: ${data['status']}');
        return null;
      }
    } else {
      print('❌ Places API 錯誤: ${response.statusCode}');
      return null;
    }
  }
}
