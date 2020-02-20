import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:weatheria/redux/actions/weather_actions.dart';
import 'package:weatheria/redux/appstate.dart';
import 'package:weatheria/screens/weatheria_home.dart';

class WeatheriaMain extends StatefulWidget {
  final Store<AppState> store;

  WeatheriaMain({this.store});

  @override
  _WeatheriaMainState createState() => _WeatheriaMainState(store: store);
}

class _WeatheriaMainState extends State<WeatheriaMain> {
  final Store<AppState> store;
  final TextEditingController _controller = TextEditingController();
  FocusNode searchFocus = FocusNode();
  String cityName;
  WeatherFetch weatherFetch = WeatherFetch();

  _WeatheriaMainState({this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          WeatheriaHome(fetchAction: weatherFetch),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                _searchButton(store),
                _currentLocationWeatherButton(store),
                _settingsButton(store, context)
              ],
              title: _searchInput(store),
            ),
          ),
        ],
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
        labelStyle: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        setState(() {
          cityName = value;
        });
      },
      onSubmitted: _controller.text.length > 0
          ? (value) {
              store.dispatch(weatherFetch.setFetchType(FetchType.CITY).setCityName(cityName));
              searchFocus.unfocus();
              _controller.clear();
            }
          : null,
    );
  }

  FloatingActionButton _searchButton(Store store) {
    return FloatingActionButton(
      heroTag: "searchBtn",
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
      onPressed: _controller.text.isNotEmpty
          ? () {
              store.dispatch(weatherFetch.setFetchType(FetchType.CITY).setCityName(cityName));
              searchFocus.unfocus();
              _controller.clear();
            }
          : null,
    );
  }

  FloatingActionButton _currentLocationWeatherButton(Store store) {
    return FloatingActionButton(
      heroTag: "locationBtn",
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.red,
      disabledElevation: 0,
      highlightElevation: 0,
      elevation: 0,
      mini: true,
      child: Icon(
        Icons.my_location,
        color: Colors.white,
      ),
      onPressed: () {
        store.dispatch(weatherFetch.setFetchType(FetchType.GPS));
        searchFocus.unfocus();
        _controller.clear();
      },
    );
  }

  FloatingActionButton _settingsButton(Store store, BuildContext context) {
    return FloatingActionButton(
        heroTag: "settingsBtn",
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
        onPressed: () {
          Navigator.pushNamed(context, "/settings");
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    searchFocus.dispose();
    super.dispose();
  }
}
