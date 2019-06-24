import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/actions/weather_actions.dart';
import 'package:weatheria/redux/appstate.dart';
import 'package:gps/gps.dart';

Middleware<AppState> appStateMiddleWare() {
  return (Store store, action, NextDispatcher next) async {
    if (action is WeatherFetch) {
      try {
        store.dispatch(WeatherLoading());
        Weather w;
        if (action.type == FetchType.CITY) {
          w = await fetchWeatherByCityName(action.cityName);
        } else if (action.type == FetchType.GPS) {
          w = await fetchWeatherByCoordinates();
        } else {
          w = await fetchWeatherByCityName(action.cityName);
        }
        store.dispatch(WeatherLoaded(weather: w));
      } catch (_) {
        store.dispatch(WeatherError());
      }
    } else {
      next(action);
    }
  };
}

Future<Weather> fetchWeatherByCityName(String cityName) async {
  String apiKeys = await rootBundle.loadString("api/api.json");
  Map<dynamic, dynamic> apiKeysDict = await jsonDecode(apiKeys);
  http.Response oWM = await http.get(
      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=${apiKeysDict["OpenWeatherMapAPI"]}");
  if (oWM.statusCode != 200) {
    throw Exception("Fetching weather failed.");
  }
  return Weather.fromJson(jsonDecode(oWM.body));
}

Future<Weather> fetchWeatherByCoordinates() async {
  String apiKeys = await rootBundle.loadString("api/api.json");
  Map<dynamic, dynamic> apiKeysDict = await jsonDecode(apiKeys);
  var latlng = await Gps.currentGps().catchError((e) => print(e));
  http.Response oWM = await http.get(
      "https://api.openweathermap.org/data/2.5/weather?lat=${latlng.lng}&lon=${latlng.lat}&appid=${apiKeysDict["OpenWeatherMapAPI"]}");
  if (oWM.statusCode != 200) {
    throw Exception("Fetching weather failed.");
  }
  return Weather.fromJson(jsonDecode(oWM.body));
}
