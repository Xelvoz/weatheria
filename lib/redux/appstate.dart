import 'package:equatable/equatable.dart';
import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/screens.dart';
import 'package:flutter/material.dart';


class AppState extends Equatable {
  final SCREENS currentScreen;
  final Weather weatherState;
  final bool isLoading;
  final bool loadingError;

  AppState({this.currentScreen, this.weatherState, this.isLoading, this.loadingError})
      : super([currentScreen, weatherState, isLoading, loadingError]);

  factory AppState.initialState() => AppState(currentScreen: SCREENS.HOME, weatherState: null, isLoading: false, loadingError: false);

  AppState copyWith({currentScreen, weatherState, isLoading, loadingError}) {
    return AppState(
        currentScreen: currentScreen ?? this.currentScreen,
        weatherState: weatherState ?? this.weatherState,
        loadingError: loadingError ?? this.loadingError,
        isLoading: isLoading ?? this.isLoading);
  }

  Color colorBegin() => (weatherState == null) ? Color(0xFF574B90) : (weatherState.icon.contains("n"))? Color(0xFF303952): Color(0xFFF19066);
  Color colorEnd() => (weatherState == null) ? Color(0xFF786FA6) : (weatherState.icon.contains("n"))? Color(0xFF596275): Color(0xFFF5CD79);

  @override
  String toString() {
    return "Weather: $weatherState, isLoading: $isLoading, loadingError: $loadingError";    
  }
}
