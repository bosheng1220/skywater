import 'package:flutter/material.dart';
import '../services/weather_service.dart';

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
    // 預設查詢台南（拼音: Tainan）
    weatherData = WeatherService().fetchWeather('Tainan');
  }

  // 查詢天氣
  void _searchWeather() {
    setState(() {
      if (cityController.text.isEmpty) {
        // 如果沒有輸入城市名，使用台南的拼音
        weatherData = WeatherService().fetchWeather('Tainan');
      } else {
        // 根據城市名查詢天氣
        weatherData = WeatherService().fetchWeather(cityController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('天氣查詢'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 輸入框
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
            // 顯示天氣資料
            FutureBuilder<Map<String, dynamic>>(
              future: weatherData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('無法取得天氣資料'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('無數據'));
                }

                var data = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('城市: ${data['name']}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('天氣: ${data['weather'][0]['description']}', style: TextStyle(fontSize: 18)),
                    Text('溫度: ${data['main']['temp']}°C', style: TextStyle(fontSize: 18)),
                    Text('最小溫度: ${data['main']['temp_min']}°C', style: TextStyle(fontSize: 18)),
                    Text('最大溫度: ${data['main']['temp_max']}°C', style: TextStyle(fontSize: 18)),
                    Text('濕度: ${data['main']['humidity']}%', style: TextStyle(fontSize: 18)),
                    Text('風速: ${data['wind']['speed']} m/s', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 20),
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
