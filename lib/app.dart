import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weatheria/redux/actions/weather_actions.dart';
import 'package:weatheria/redux/appstate.dart';
import 'package:weatheria/screens/weatheria_home.dart';

class Weatheria extends StatefulWidget {
  final Store store;

  Weatheria({this.store});

  @override
  _WeatheriaState createState() => _WeatheriaState(store: store);
}

class _WeatheriaState extends State<Weatheria> {
  final Store store;
  FocusNode searchFocus = FocusNode();
  String cityName;

  _WeatheriaState({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            children: <Widget>[
              WeatheriaHome(),
              AppBar(
                leading: Icon(
                  Icons.map,
                  color: Colors.white54,
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: <Widget>[_searchButton(store)],
                title: _searchInput(store),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField _searchInput(Store store) {
    return TextField(
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      focusNode: searchFocus,
      cursorWidth: 1,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        labelText: "Search for a city",
        labelStyle:
            TextStyle(color: Colors.white54, fontWeight: FontWeight.bold),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        setState(() {
         cityName = value; 
        });
      },
      onSubmitted: (value) {
        store.dispatch(WeatherFetch(cityName: cityName));
      },
    );
  }

  FloatingActionButton _searchButton(Store store) {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.red,
      disabledElevation: 0,
      highlightElevation: 0,
      elevation: 0,
      mini: true,
      child: Icon(
        Icons.search,
        color: Colors.white,
      ),
      onPressed: () {
        store.dispatch(WeatherFetch(cityName: cityName));
        searchFocus.unfocus();
      },
    );
  }
}
