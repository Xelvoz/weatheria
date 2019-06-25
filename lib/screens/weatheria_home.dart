import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/actions/weather_actions.dart';
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
        onInit: (store) {
          store.dispatch(WeatherFetch(type: FetchType.GPS));
        },
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _displayCityAndCountryName(state),
              _displayCityDateAndTime(state),
              Expanded(
                child: Container(),
              ),
              _displayGeneralTemperatureWithIcon(
                  state: state,
                  temperature: state.weatherState.temperature,
                  icon: state.weatherState.weatherIcon()),
              // _horizontalDivider(context),
              Expanded(
                child: Container(),
              ),
              _displaySunsetAndSunrise(state),
              Expanded(
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                _weatherInfoTile(
                  icon: Icon(WeatherIcons.wind, color: Colors.white70, size: 40,),
                  iconBackground: Colors.blueGrey,
                  title: Text("${state.weatherState.windSpeed} m/s", style: TextStyle(color: Colors.white70),),
                  description: Text("${state.weatherState.windDirection}°", style: TextStyle(color: Colors.white70),),
                  padding: 25
                ),
                _weatherInfoTile(
                  icon: Icon(Icons.opacity, color: Colors.lightBlue[100], size: 40,),
                  iconBackground: Colors.blueGrey,
                  title: Text("Humidity", style: TextStyle(color: Colors.white70),),
                  description: Text("${state.weatherState.humidity}%", style: TextStyle(color: Colors.white70),),
                  padding: 15
                ),
              ],),
              Expanded(
                child: Container(),
              ),
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
                color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
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
              decoration: TextDecoration.overline,
            ),
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
            time: state.weatherState.sunrise + state.weatherState.timezone,
            mode: sunMode.SUNRISE,
            iconColor: Colors.yellow[200]),
        _displaySunsetOrSunrise(
            time: state.weatherState.sunset + state.weatherState.timezone,
            mode: sunMode.SUNSET,
            iconColor: Colors.red[200]),
      ],
    );
  }

  Container _verticalDivider() {
    return Container(
        width: 1,
        height: 40,
        decoration: BoxDecoration(color: Colors.white70),
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
        fontSize: 12,
      ),
    );
  }

  Widget _displayGeneralTemperatureWithIcon(
      {AppState state, Temperature temperature, IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              "${state.temperatureWithUnits(temperature: temperature)}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 60, color: Colors.white70),
            ),
            Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.trending_up, color: Colors.redAccent, size: 18),
                    SizedBox(width: 10,),
                    Text(
                      "${state.temperatureWithUnits(temperature: state.weatherState.temperature.maxTemperature())}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.trending_down,
                        color: Colors.cyanAccent, size: 18),
                    SizedBox(width: 10,),
                    Text(
                      "${state.temperatureWithUnits(temperature: state.weatherState.temperature.minTemperature())}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ]..addAll(icon != null
          ? [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 1,
                  height: 80,
                  decoration: BoxDecoration(color: Colors.white70),
                ),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.blueGrey),
            child: Icon(
              WeatherIcons.sunrise,
              size: 40,
              color: iconColor,
            ),  
          ),
          SizedBox(
            width: 25,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(time * 1000).toUtc())}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
              Text(
                mode == sunMode.SUNSET ? "Sunset" : "Sunrise",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white70),
              )
            ],
          ),
        ]);
  }

  Widget _weatherInfoTile({Icon icon, Color iconBackground, Text title, Text description, double padding}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: iconBackground),
            child: icon
          ),
          SizedBox(
            width: padding,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              title,
              description
            ],
          ),
        ]);
  }
}

enum sunMode { SUNSET, SUNRISE }
