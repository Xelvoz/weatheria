import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/actions/weather_actions.dart';
import 'package:weatheria/redux/appstate.dart';

class WeatheriaSettings extends StatefulWidget {
  final Store<AppState> store;

  WeatheriaSettings({this.store});

  @override
  _WeatheriaSettingsState createState() =>
      _WeatheriaSettingsState(store: store);
}

class _WeatheriaSettingsState extends State<WeatheriaSettings> {
  final Store<AppState> store;
  Units unit;

  _WeatheriaSettingsState({this.store});

  @override
  void initState() {
    super.initState();
    unit = store.state.weatherState?.temperature?.unit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _displaySettings(store: store),
          AppBar(
            leading: _backButton(context),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ],
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return FloatingActionButton(
        heroTag: "backBtn",
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        disabledElevation: 0,
        highlightElevation: 0,
        elevation: 0,
        mini: true,
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }

  Widget _displaySettings({Store<AppState> store}) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
            Color(0xFF2c3e50),
            Color(0xFF34495e),
            Color(0xFF596275),
          ])),
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: ListView(
          children: <Widget>[
            _displayUnitsSettings(store: store),
          ],
        ),
      ),
    );
  }

  Widget _displayUnitsSettings({Store<AppState> store}) {
    return ListTile(
      dense: true,
      enabled: true,
      selected: true,
      title: Text(
        "Temperature Unit",
        style: TextStyle(
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dotted,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
      subtitle: Text(
        "Default: Celsius.\nAvailable units: Celsius, Fahrenheit, Kelvin.",
        style: TextStyle(
            fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white54),
      ),
      trailing: DropdownButton(
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white54),
        isDense: true,
        value: unit,
        onChanged: (value) {
          store.dispatch(ChangeUnit(unit: value));
          setState(() {
            unit = value;
          });
        },
        items: <DropdownMenuItem>[
          DropdownMenuItem(
            value: Units.Celsius,
            child: Text("Celsius"),
          ),
          DropdownMenuItem(
            value: Units.Fahrenheit,
            child: Text("Fahrenheit"),
          ),
          DropdownMenuItem(
            value: Units.Kelvin,
            child: Text("Kelvin"),
          ),
        ],
      ),
    );
  }
}
