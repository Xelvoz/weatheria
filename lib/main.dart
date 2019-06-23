import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:weatheria/app.dart';
import 'package:weatheria/redux/appstate.dart';
import 'package:weatheria/redux/middleware/weather_middleware.dart';
import 'package:weatheria/redux/reducers/weather_reducers.dart';
import 'package:redux_logging/redux_logging.dart';

void main() {
  final store = new Store<AppState>(appStateReducer, initialState: AppState.initialState(), middleware: [appStateMiddleWare(), LoggingMiddleware.printer()]);

  runApp(Weatheria(store: store));
} 
