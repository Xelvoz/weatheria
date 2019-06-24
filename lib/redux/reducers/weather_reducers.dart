import 'package:weatheria/redux/actions/weather_actions.dart';
import 'package:weatheria/redux/appstate.dart';

AppState appStateReducer(AppState state, dynamic action) {

  if (action is ChangeUnit) {
    AppState newState = state.copyWith(unit: action.unit);
    return newState;
  }

  if (action is WeatherLoading) {
    return state.copyWith(status: Status.LOADING);
  }

  if (action is WeatherError) {
    return state.copyWith(status: Status.ERROR);
  }

  if (action is WeatherLoaded) {
    return state.copyWith(weatherState: action.weather, status: Status.LOADED);
  }

  return state;
}