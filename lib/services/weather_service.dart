import 'dart:convert';

import 'package:http/http.dart' as HttpClient;
import 'package:i_weather/model/weather_data.dart';

const API_KEY = '1212c14b52d7f7e69a9d228d73f1cb0b';

class WeatherService {
  Future<WeatherData> getWeatherData({double lat, double lon}) async {
    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$API_KEY&units=metric');
    try {
      HttpClient.Response response = await HttpClient.get(uri);
      if (response.statusCode == 200) {
        print('response:${response.body}');
        Map<String, dynamic> parsedData = jsonDecode(response.body);
        return WeatherData.fromJson(parsedData);
      } else {
        print('Unable to fetch weather data');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
