import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:weatheria/screens/weather_icons.dart';

class Weather extends Equatable {
  final double longitude;
  final double latitude;
  final int time;

  final int sunrise;
  final int sunset;

  final Temperature temperature;

  final int pressure;
  final double humidity;

  final int visibility;

  final double windSpeed;
  final int windDirection;

  final String city;
  final String country;

  final int timezone;
  final String icon;

  Weather(
      {this.longitude,
      this.latitude,
      this.time,
      this.sunrise,
      this.sunset,
      this.temperature,
      this.humidity,
      this.pressure,
      this.visibility,
      this.windSpeed,
      this.windDirection,
      this.city,
      this.country,
      this.timezone,
      this.icon})
      : super([
          longitude,
          latitude,
          time,
          sunrise,
          sunset,
          temperature,
          humidity,
          pressure,
          visibility,
          windSpeed,
          windDirection,
          city,
          country,
          timezone,
          icon
        ]);

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
      longitude: json["lon"],
      latitude: json["lat"],
      time: json["dt"],
      sunrise: json["sys"]["sunrise"],
      sunset: json["sys"]["sunset"],
      timezone: json["timezone"],
      icon: json["weather"][0]["icon"],
      temperature: Temperature(
          temp: json["main"]["temp"],
          maxTemp: json["main"]["temp_max"],
          minTemp: json["main"]["temp_min"]),
      humidity: json["main"]["temp"],
      pressure: json["main"]["pressure"],
      visibility: json["visibility"],
      windSpeed: (json["wind"]["speed"] as double),
      windDirection: json["wind"]["deg"],
      city: json["name"],
      country: json["sys"]["country"]);
  
  IconData weatherIcon() {
   switch (icon) {
     case "01d":
      return WeatherIcons.sun;
    case "01n":
      return WeatherIcons.moon;
    case "02d":
      return WeatherIcons.cloud_sun;
    case "02n":
      return WeatherIcons.cloud_moon;
    case "03d":
    case "03n":
      return WeatherIcons.cloud;
    case "04d":
    case "04n":
      return WeatherIcons.clouds;
    case "09d":
    case "09n":
    case "10d":
    case "10n":
      return WeatherIcons.rain;
    case "11d":
    case "11n":
      return WeatherIcons.cloud_flash;
    case "11d":
    case "11n":
      return WeatherIcons.snow;
    case "50d":
      return WeatherIcons.fog;
    case "50n":
      return WeatherIcons.fog_moon;
    default:
      return null;
   }
  }
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
