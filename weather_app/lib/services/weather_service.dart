import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = '1281b4841802446cb1015124232201';
  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weatherData;

    Uri url =
        Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');
    http.Response response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);

    weatherData = WeatherModel.fromJson(data);

    return weatherData;
  }
}
