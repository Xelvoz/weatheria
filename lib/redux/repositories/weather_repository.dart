import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gps/gps.dart';
import 'package:weatheria/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherRespository {
  static Future<Weather> fetchWeatherByCityName(String cityName) async {
    String apiKey = DotEnv().env['OpenWeatherMapAPI'];
    http.Response oWM =
        await http.get("https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey");
    if (oWM.statusCode != 200) {
      throw Exception("Fetching weather failed.");
    }
    return Weather.fromJson(jsonDecode(oWM.body));
  }

  static Future<Weather> fetchWeatherByCoordinates() async {
    String apiKey = DotEnv().env['OpenWeatherMapAPI'];
    var latlng = await Gps.currentGps().catchError((e) => print(e));
    http.Response oWM = await http.get(
        "https://api.openweathermap.org/data/2.5/weather?lat=${latlng.lat}&lon=${latlng.lng}&appid=$apiKey");
    if (oWM.statusCode != 200) {
      throw Exception("Fetching weather failed.");
    }
    return Weather.fromJson(jsonDecode(oWM.body));
  }
}
