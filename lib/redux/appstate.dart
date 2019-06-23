import 'package:equatable/equatable.dart';
import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/screens.dart';

class AppState extends Equatable {
  final SCREENS currentScreen;
  final Weather weatherState;
  bool weatherLoadingError = false;

  AppState({this.currentScreen, this.weatherState})
      : super([currentScreen, weatherState]);

  factory AppState.initialState() => AppState(currentScreen: SCREENS.HOME, weatherState: null);

  AppState copyWith({currentScreen, weatherState}) {
    return AppState(
        currentScreen: currentScreen ?? this.currentScreen,
        weatherState: weatherState ?? this.weatherState);
  }
}
