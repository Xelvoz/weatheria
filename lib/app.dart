import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:weatheria/redux/appstate.dart';
import 'package:weatheria/screens/routes.dart';
import 'package:weatheria/screens/weatheria_main.dart';

class Weatheria extends StatelessWidget {
  final Store<AppState> store;

  Weatheria({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: "Weatheria 🌞",
        routes: Routes.routes,
        theme: ThemeData(fontFamily: "Mali"),
        debugShowCheckedModeBanner: false,
        home: WeatheriaMain(
          store: store,
        ),
      ),
    );
  }
}
