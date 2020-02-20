import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/repositories/weather_repository.dart';
import 'package:weatheria/redux/appstate.dart';

enum FetchType { CITY, GPS }
enum Status { IDLE, LOADING, COMPLETE, ERROR }

abstract class ReactiveAction<T> extends ReduxAction<AppState> {
  StreamController<T> _reactiveStream;

  ReactiveAction() {
    _reactiveStream = StreamController();
  }

  void addEvent(T event) {
    _reactiveStream?.add(event);
  }

  void closeReactiveStream() {
    _reactiveStream?.close();
  }

  Stream<T> get stream => _reactiveStream?.stream;
}

class ChangeUnit extends ReactiveAction<Status> {
  final Units unit;

  ChangeUnit({this.unit});

  @override
  String toString() {
    return "Changing temperature unit to $unit";
  }

  @override
  AppState reduce() {
    Weather weather = state.weatherState;
    return state.copyWith(
      weatherState: weather.copyWith(
        temperature: weather.temperature.copyWith(unit: unit),
      ),
    );
  }
}

class WeatherFetch extends ReactiveAction<Status> {
  String cityName;
  FetchType type;

  WeatherFetch({this.cityName, this.type = FetchType.CITY});

  WeatherFetch setCityName(String cityName) {
    this.cityName = cityName;
    return this;
  }

  WeatherFetch setFetchType(FetchType type) {
    this.type = type;
    return this;
  }

  @override
  String toString() {
    switch (type) {
      case (FetchType.CITY):
        return "Fetching weather for search query: $cityName";
      case (FetchType.GPS):
        return "Fetching weather by GPS coordinates.";
      default:
        return "Fetching weather info...";
    }
  }

  @override
  FutureOr<void> before() {
    _reactiveStream.add(Status.LOADING);
  }

  @override
  Future<AppState> reduce() async {
    Weather weather;
    switch (type) {
      case (FetchType.CITY):
        weather = await WeatherRespository.fetchWeatherByCityName(cityName);
        break;
      case (FetchType.GPS):
      default:
        weather = await WeatherRespository.fetchWeatherByCoordinates();
        break;
    }
    return state.copyWith(weatherState: weather);
  }

  @override
  void after() {
    if (state.weatherState == null) {
      _reactiveStream.add(Status.ERROR);
    } else {
      _reactiveStream.add(Status.COMPLETE);
    }
  }
}
