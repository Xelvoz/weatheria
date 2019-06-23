import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/appstate.dart';
import 'package:weatheria/screens/weather_icons.dart';

class WeatheriaHome extends StatefulWidget {
  @override
  _WeatheriaHomeState createState() => _WeatheriaHomeState();
}

class _WeatheriaHomeState extends State<WeatheriaHome> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        distinct: true,
        converter: (store) => store.state,
        builder: (context, state) => Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [state.colorBegin(), state.colorEnd()])),
              child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Column(
                    children: <Widget>[
                      Expanded(child: _displayWeatherInfo(context, state))
                    ],
                  )),
            ));
  }

  Widget _displayWeatherInfo(BuildContext context, AppState state) {
    if (state.status == Status.ERROR) {
      return _displayErrorScreen();
    } else if (state.status == Status.IDLE) {
      return _displayStartingScreenHelper();
    } else {
      if (state.status == Status.LOADING) {
        return _displayLoadingIndicator();
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _displayCityAndCountryName(state),
              _displayCityDateAndTime(state),
              _displayGeneralTemperatureWithIcon(
                  temperature: state.weatherState.temperature,
                  icon: state.weatherState.weatherIcon()),
              _horizontalDivider(context),
              _displaySunsetAndSunrise(state),
            ],
          ),
        );
      }
    }
  }

  Center _displayErrorScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.warning,
            size: 100,
            color: Colors.red[300],
          ),
          Text(
            "Oops... Something went wrong...",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Text(
            "Please check your internet or the city name you gave.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Center _displayStartingScreenHelper() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.arrow_upward,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "Please choose a city above.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                decorationStyle: TextDecorationStyle.dotted,
                decoration: TextDecoration.combine([
                  TextDecoration.overline,
                ])),
          )
        ],
      ),
    );
  }

  Center _displayLoadingIndicator() {
    return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xF3A683FF)),
          backgroundColor: Color(0xF19066FF),
        ),
      );
  }

  Row _displaySunsetAndSunrise(AppState state) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _displaySunsetOrSunrise(
                    time: state.weatherState.sunrise +
                        state.weatherState.timezone,
                    mode: sunMode.SUNRISE,
                    iconColor: Colors.yellow[200]),
                Container(
                  width: 1,
                  height: 30,
                  decoration: BoxDecoration(color: Colors.white70),
                ),
                _displaySunsetOrSunrise(
                    time: state.weatherState.sunset +
                        state.weatherState.timezone,
                    mode: sunMode.SUNSET,
                    iconColor: Colors.red[200]),
              ],
            );
  }

  Container _horizontalDivider(BuildContext context) {
    return Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 1,
              decoration: BoxDecoration(color: Colors.white70),
            );
  }

  Text _displayCityAndCountryName(AppState state) {
    return Text(
              "${state.weatherState.city}, ${state.weatherState.country}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  decorationStyle: TextDecorationStyle.dotted,
                  decoration: TextDecoration.combine([
                    TextDecoration.underline,
                  ])),
            );
  }

  Text _displayCityDateAndTime(AppState state) {
    return Text(
              "${DateFormat.yMMMMd().add_Hm().format(DateTime.fromMillisecondsSinceEpoch((state.weatherState.time + state.weatherState.timezone) * 1000).toUtc())}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  decorationStyle: TextDecorationStyle.dotted,
                  decoration: TextDecoration.combine([
                    TextDecoration.underline,
                  ])),
            );
  }

  Widget _displayGeneralTemperatureWithIcon(
      {Temperature temperature, IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          "$temperature",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 60, color: Colors.white70),
        ),
      ]..addAll(icon != null
          ? [
              Container(
                width: 1,
                height: 60,
                decoration: BoxDecoration(color: Colors.white70),
              ),
              Icon(
                icon,
                size: 70,
                color: Colors.white70,
              )
            ]
          : []),
    );
  }

  Widget _displaySunsetOrSunrise({sunMode mode, int time, Color iconColor}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blueGrey),
                child: Icon(
                  WeatherIcons.sunrise,
                  size: 30,
                  color: iconColor,
                ),
              ),
              Text(
                mode == sunMode.SUNSET ? "Sunset" : "Sunrise",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white70),
              )
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(time * 1000).toUtc())}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white70),
          )
        ]);
  }
}

enum sunMode { SUNSET, SUNRISE }
