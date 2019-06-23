import 'package:equatable/equatable.dart';
import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/screens.dart';

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

  @override
  String toString() {
    return "isLoading: $isLoading, loadingError: $loadingError";    
  }
}
