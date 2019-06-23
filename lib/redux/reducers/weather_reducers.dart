import 'package:weatheria/redux/actions/weather_actions.dart';
import 'package:weatheria/redux/appstate.dart';

AppState appStateReducer(AppState state, dynamic action) {

  if (action is WeatherLoading) {
    return state.copyWith(isLoading: true);
  }

  if (action is WeatherError) {
    return state.copyWith(loadingError: true);
  }

  if (action is WeatherLoaded) {
    return state.copyWith(weatherState: action.weather, loadingError: false, isLoading: false);
  }

  return state;
}