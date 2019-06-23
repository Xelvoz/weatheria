import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double longitude;
  final double latitude;
  final int time;

  final Temperature temperature;

  final int pressure;
  final double humidity;

  final int visibility;

  final double windSpeed;
  final int windDirection;

  final String city;
  final String country;

  Weather(
      {this.longitude,
      this.latitude,
      this.time,
      this.temperature,
      this.humidity,
      this.pressure,
      this.visibility,
      this.windSpeed,
      this.windDirection,
      this.city,
      this.country})
      : super([
          longitude,
          latitude,
          time,
          temperature,
          humidity,
          pressure,
          visibility,
          windSpeed,
          windDirection,
          city,
          country
        ]);

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
      longitude: json["lon"],
      latitude: json["lat"],
      time: json["dt"],
      temperature: Temperature(
          temp: json["main"]["temp"],
          maxTemp: json["main"]["temp_max"],
          minTemp: json["main"]["temp_min"]),
      humidity: json["main"]["temp"],
      pressure: json["main"]["pressure"],
      visibility: json["visibility"],
      windSpeed: json["wind"]["speed"],
      windDirection: json["wind"]["deg"],
      city: json["name"],
      country: json["sys"]["country"]);
}

enum Units { Kelvin, Celsius, Fahrenheit }

class Temperature {
  final double temp;
  final double minTemp;
  final double maxTemp;
  Units unit = Units.Celsius;

  Temperature({this.temp, this.minTemp, this.maxTemp});

  int get temperatureInCelsius => (temp - 273.15).round();
  int get minTemperatureInCelsius => (minTemp - 273.15).round();
  int get maxTemperatureInCelsius => (maxTemp - 273.15).round();

  int get temperatureInFahrenheit => (temp - 273.15).round();
  int get minTemperatureInFahrenheit => (minTemp - 273.15).round();
  int get maxTemperatureInFahrenheit => (maxTemp - 273.15).round();

  @override
  String toString() {
    switch (unit) {
      case Units.Celsius:
        return "$temperatureInCelsius°C";
      case Units.Fahrenheit:
        return "$temp°K";
      case Units.Kelvin:
        return "$temperatureInFahrenheit°F";
      default:
        return "$temperatureInCelsius°C";
    }
  }
}
