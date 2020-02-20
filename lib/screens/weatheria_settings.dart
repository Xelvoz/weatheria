import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/actions/weather_actions.dart';
import 'package:weatheria/redux/appstate.dart';

import '../redux/appstate.dart';

class WeatheriaSettings extends StatefulWidget {
  @override
  _WeatheriaSettingsState createState() => _WeatheriaSettingsState();
}

class _WeatheriaSettingsState extends State<WeatheriaSettings> {
  Units unit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      onInit: (store) {
        print(unit);
        unit = store.state.weatherState.temperature.unit;
        print(unit);
      },
      converter: (store) => store,
      builder: (context, store) => Scaffold(
        body: Stack(
          children: <Widget>[
            _displaySettings(store: store),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                leading: _backButton(context),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ],
        ),
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
        style: TextStyle(fontSize: 9, color: Colors.white54),
      ),
      trailing: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.blueGrey,
        ),
        child: DropdownButton(
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white70),
          isDense: true,
          value: unit,
          onChanged: (value) {
            store.dispatch(ChangeUnit(unit: value));
            setState(() {
              unit = value;
            });
          },
          items: Units.values
              .map((u) => DropdownMenuItem(
                    value: u,
                    child: Text(
                      u.toString().split(".")[1],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
