import 'package:equatable/equatable.dart';
import 'package:weatheria/models/weather.dart';
import 'package:flutter/material.dart';

class AppState extends Equatable {
  final Weather weatherState;

  AppState({this.weatherState});

  factory AppState.initialState() => AppState(weatherState: null);

  AppState copyWith({Weather weatherState}) {
    return AppState(
      weatherState: weatherState ?? this.weatherState,
    );
  }

  Color colorBegin() => (weatherState == null)
      ? Color(0xFF574B90)
      : ((weatherState.sunrise >= weatherState.time && weatherState.time <= weatherState.sunset) ||
              (weatherState.icon.contains("n")))
          ? Color(0xFF303952)
          : Color(0xFF4a69bd);

  Color colorEnd() => (weatherState == null)
      ? Color(0xFF786FA6)
      : ((weatherState.sunrise >= weatherState.time && weatherState.time <= weatherState.sunset) ||
              (weatherState.icon.contains("n")))
          ? Color(0xFF596275)
          : Color(0xFF6a89cc);

  @override
  List<Object> get props => [weatherState];

  @override
  String toString() {
    return weatherState.toString();
  }
}
