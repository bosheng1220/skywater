import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../services/places_service.dart';
import '../services/pinyin_converter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cityController = TextEditingController();
  late Future<Map<String, dynamic>> weatherData;

  @override
  void initState() {
    super.initState();
    // 預設查詢台南
    weatherData = WeatherService().fetchWeather('Tainan');
  }

  void searchWeather(String inputChinese) {
    String pinyin = PinyinConverter.toPinyin(inputChinese);
    print('🔍 查詢拼音城市: $pinyin');
    // 呼叫 Weather API，例如 OpenWeatherMap
  }

void _searchWeather() async {
  final input = cityController.text.trim();
  final query = input.isEmpty ? 'Tainan' : input;

  final placesService = PlacesService();
  final englishCity = await placesService.getEnglishCity(query);

  String cityToSearch;

  if (englishCity != null) {
    cityToSearch = englishCity;
    print('✅ 使用 Google Places 取得英文地名: $englishCity');
  } else {
    // 若 Places 無法解析，則用拼音轉換
    final pinyin = PinyinConverter.toPinyin(query);
    cityToSearch = pinyin;
    print('⚠️ 使用拼音備案查詢: $pinyin');
  }

  setState(() {
    weatherData = WeatherService().fetchWeather(cityToSearch);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('天氣查詢')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: '請輸入城市名稱',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchWeather,
                ),
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<Map<String, dynamic>>(
              future: weatherData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('取得天氣資料失敗');
                } else if (!snapshot.hasData) {
                  return Text('無資料');
                }

                final data = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '城市: ${data['name']}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('天氣: ${data['weather'][0]['description']}'),
                    Text('溫度: ${data['main']['temp']}°C'),
                    Text('濕度: ${data['main']['humidity']}%'),
                    Text('風速: ${data['wind']['speed']} m/s'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
