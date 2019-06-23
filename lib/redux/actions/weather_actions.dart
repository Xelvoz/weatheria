import 'package:weatheria/models/weather.dart';

abstract class WeatherActions {}



class WeatherFetch extends WeatherActions {
  final String cityName;

  WeatherFetch({this.cityName});

  @override
  String toString() {
    return "Fetching weather for search query: $cityName";    
  }
}

class WeatherError extends WeatherActions {
  @override
  String toString() {
    return "Weather failed to load";
  }
}

class WeatherLoading extends WeatherActions {
  @override
  String toString() {
    return "Weather is being loaded";
  }
}

class WeatherLoaded extends WeatherActions {
  final Weather weather;

  WeatherLoaded({this.weather});

  @override
  String toString() {
    return "Weather has been loaded for ${weather.city}";
  }
}