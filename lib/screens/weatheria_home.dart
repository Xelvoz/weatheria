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
                      colors: [
                    state.colorBegin(),
                    state.colorEnd()
                  ])),
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
    if (state.loadingError) {
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
    } else if (state.weatherState == null) {
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
    } else {
      if (state.isLoading) {
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xF3A683FF)),
            backgroundColor: Color(0xF19066FF),
          ),
        );
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "${state.weatherState.city}, ${state.weatherState.country}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    decorationStyle: TextDecorationStyle.dotted,
                    decoration: TextDecoration.combine([
                      TextDecoration.underline,
                    ])),
              ),
              _displayGeneralTemperatureWithIcon(
                  temperature: state.weatherState.temperature,
                  icon: state.weatherState.weatherIcon()),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 1,
                decoration: BoxDecoration(color: Colors.white70),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displaySunsetAndSunrise(
                      time: state.weatherState.sunrise +
                          state.weatherState.timezone,
                      mode: sunMode.SUNRISE,
                      iconColor: Colors.yellow[200]),
                  Container(
                    width: 1,
                    height: 30,
                    decoration: BoxDecoration(color: Colors.white70),
                  ),
                  _displaySunsetAndSunrise(
                      time: state.weatherState.sunset +
                          state.weatherState.timezone,
                      mode: sunMode.SUNSET,
                      iconColor: Colors.red[200]),
                ],
              ),
            ],
          ),
        );
      }
    }
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
      ]..addAll(
        icon != null ?
        [
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
        ] : []
      ),
    );
  }

  Widget _displaySunsetAndSunrise({sunMode mode, int time, Color iconColor}) {
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
