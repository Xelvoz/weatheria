import 'package:equatable/equatable.dart';
import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/screens.dart';
import 'package:flutter/material.dart';

enum Status {IDLE, LOADING, LOADED, ERROR}

class AppState extends Equatable {
  final SCREENS currentScreen;
  final Weather weatherState;
  final Status status;
  final Units unit;

  AppState(
      {this.currentScreen,
      this.weatherState,
      this.status,
      this.unit})
      : super([currentScreen, weatherState, status, unit]);

  factory AppState.initialState() => AppState(
      currentScreen: SCREENS.HOME,
      weatherState: null,
      status: Status.IDLE,
      unit: Units.Celsius);

  AppState copyWith({currentScreen, weatherState, status, unit}) {
    return AppState(
        currentScreen: currentScreen ?? this.currentScreen,
        weatherState: weatherState ?? this.weatherState,
        status: status ?? this.status,
        unit: unit ?? this.unit);
  }

  Color colorBegin() => (weatherState == null)
      ? Color(0xFF574B90)
      : ((weatherState.sunrise >= weatherState.time &&
              weatherState.time <= weatherState.sunset) || (weatherState.icon.contains("n")))
          ? Color(0xFF303952)
          : Color(0xFF4a69bd);

  Color colorEnd() => (weatherState == null)
      ? Color(0xFF786FA6)
      : ((weatherState.sunrise >= weatherState.time &&
              weatherState.time <= weatherState.sunset) || (weatherState.icon.contains("n")))
          ? Color(0xFF596275)
          : Color(0xFF6a89cc);
  
  String temperatureWithUnits({Temperature temperature}) {
    switch (unit) {
      case Units.Celsius:
        return "${temperature.temperatureInCelsius}°C";
      case Units.Kelvin:
        return "${temperature.temp.round()}°K";
      case Units.Fahrenheit:
        return "${temperature.temperatureInFahrenheit}°F";
      default:
        return "${temperature.temperatureInCelsius}°C";
    }
  }

  @override
  String toString() {
    return "Weather: $weatherState, Status: ${status.toString()}";
  }
}

