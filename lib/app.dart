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
  final TextEditingController _controller = TextEditingController();
  final Store store;
  FocusNode searchFocus = FocusNode();
  String cityName;

  _WeatheriaState({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Mali"),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            children: <Widget>[
              WeatheriaHome(),
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: <Widget>[
                  _searchButton(store),
                  _settingsButton(store, context)
                ],
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
      controller: _controller,
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
        searchFocus.unfocus();
        _controller.clear();
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
      onPressed: _controller.text.length > 0
          ? () {
              store.dispatch(WeatherFetch(cityName: cityName));
              searchFocus.unfocus();
              _controller.clear();
            }
          : null,
    );
  }

  FloatingActionButton _settingsButton(Store store, BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        disabledElevation: 0,
        highlightElevation: 0,
        elevation: 0,
        mini: true,
        child: Icon(
          Icons.settings,
          color: Colors.white,
        ),
        onPressed: () => {});
  }

  @override
  void dispose() {
    _controller.dispose();
    searchFocus.dispose();
    super.dispose();
  }
}
