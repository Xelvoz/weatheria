import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/actions/weather_actions.dart';
import 'package:weatheria/redux/appstate.dart';

Middleware<AppState> appStateMiddleWare() {
  return (Store store, action, NextDispatcher next) async {
		if (action is WeatherFetch) {
      try {
        store.dispatch(WeatherLoading());
        Weather w = await fetchWeather(action.cityName);
        store.dispatch(WeatherLoaded(weather: w));
      } catch (_) {
        store.dispatch(WeatherError());
      }
    }
    next(action);
  };
}


Future<Weather> fetchWeather(String cityName) async {
  String apiKeys = await rootBundle.loadString("api/api.json");
  Map<dynamic, dynamic> apiKeysDict = await jsonDecode(apiKeys);
  http.Response OWM = await http.get("http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=${apiKeysDict["OpenWeatherMapAPI"]}");
  if (OWM.statusCode != 200) {
    throw Exception("Fetching weather failed.");
  }
  return Weather.fromJson(jsonDecode(OWM.body));
}