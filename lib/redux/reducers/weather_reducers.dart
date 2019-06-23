import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/actions/weather_actions.dart';
import 'package:weatheria/redux/appstate.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(weatherState: weatherReducer(state, action));
}

Weather weatherReducer(AppState state, dynamic action) {
  if (action is WeatherError) {
    state.weatherLoadingError = true;
  }

  if (action is WeatherLoaded) {
    state.weatherLoadingError = false;
    return action.weather;
  }

  return null;
}