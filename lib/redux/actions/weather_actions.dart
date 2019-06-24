import 'package:weatheria/models/weather.dart';

enum FetchType {CITY, GPS}

abstract class WeatherActions {}


class ChangeUnit extends WeatherActions {
  final Units unit;

  ChangeUnit({this.unit});

  @override
  String toString() {
    return "Changing temperature unit to $unit";    
  }
}

class WeatherFetch extends WeatherActions {
  final String cityName;
  final FetchType type;

  WeatherFetch({this.cityName, this.type = FetchType.CITY});

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