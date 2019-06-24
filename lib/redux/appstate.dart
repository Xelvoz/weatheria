import 'package:equatable/equatable.dart';
import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/screens.dart';
import 'package:flutter/material.dart';

enum Status {IDLE, LOADING, LOADED, ERROR}

class AppState extends Equatable {
  final SCREENS currentScreen;
  final Weather weatherState;
  final Status status;

  AppState(
      {this.currentScreen,
      this.weatherState,
      this.status})
      : super([currentScreen, weatherState, status]);

  factory AppState.initialState() => AppState(
      currentScreen: SCREENS.HOME,
      weatherState: null,
      status: Status.IDLE);

  AppState copyWith({currentScreen, weatherState, status}) {
    return AppState(
        currentScreen: currentScreen ?? this.currentScreen,
        weatherState: weatherState ?? this.weatherState,
        status: status ?? this.status);
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

  @override
  String toString() {
    return "Weather: $weatherState, Status: ${status.toString()}";
  }
}

