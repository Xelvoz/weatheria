import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weatheria/models/weather.dart';

import '../weather_icons.dart';

class WeatherInfo extends StatelessWidget {
  final Weather weather;

  WeatherInfo({this.weather});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _displayCityAndCountryName(weather),
          _displayCityDateAndTime(weather),
          Expanded(
            child: Container(),
          ),
          _displayGeneralTemperatureWithIcon(weather),
          // _horizontalDivider(context),
          Expanded(
            child: Container(),
          ),
          _displaySunsetAndSunrise(weather),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _weatherInfoTile(
                  icon: Icon(
                    WeatherIcons.wind,
                    color: Colors.white70,
                    size: 40,
                  ),
                  iconBackground: Colors.blueGrey,
                  title: Text(
                    "${weather.windSpeed} m/s",
                    style: TextStyle(color: Colors.white70),
                  ),
                  description: Text(
                    "${weather.windDirection}°",
                    style: TextStyle(color: Colors.white70),
                  ),
                  padding: 25),
              _weatherInfoTile(
                  icon: Icon(
                    Icons.opacity,
                    color: Colors.lightBlue[100],
                    size: 40,
                  ),
                  iconBackground: Colors.blueGrey,
                  title: Text(
                    "Humidity",
                    style: TextStyle(color: Colors.white70),
                  ),
                  description: Text(
                    "${weather.humidity}%",
                    style: TextStyle(color: Colors.white70),
                  ),
                  padding: 15),
            ],
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Row _displaySunsetAndSunrise(Weather weather) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _displaySunsetOrSunrise(
            time: weather.sunrise + weather.timezone,
            mode: sunMode.SUNRISE,
            iconColor: Colors.yellow[200]),
        _displaySunsetOrSunrise(
            time: weather.sunset + weather.timezone,
            mode: sunMode.SUNSET,
            iconColor: Colors.red[200]),
      ],
    );
  }

  // Container _verticalDivider() {
  //   return Container(
  //     width: 1,
  //     height: 40,
  //     decoration: BoxDecoration(color: Colors.white70),
  //   );
  // }

  // Container _horizontalDivider(BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width / 2,
  //     height: 1,
  //     decoration: BoxDecoration(color: Colors.white70),
  //   );
  // }

  Text _displayCityAndCountryName(Weather weather) {
    return Text(
      "${weather.city}, ${weather.country}",
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

  Text _displayCityDateAndTime(Weather weather) {
    var time =
        DateTime.fromMillisecondsSinceEpoch((weather.time + weather.timezone) * 1000).toUtc();
    return Text(
      "${DateFormat.yMMMMd().add_Hm().format(time)}",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    );
  }

  Widget _displayGeneralTemperatureWithIcon(Weather weather) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              "${weather.temperature}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 60, color: Colors.white70),
            ),
            Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.trending_up, color: Colors.redAccent, size: 18),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${weather.temperature.maxTemperature()}",
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
                    Icon(Icons.trending_down, color: Colors.cyanAccent, size: 18),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${weather.temperature.minTemperature()}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ]..addAll(weather.icon != null
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
                weather.weatherIcon(),
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
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueGrey),
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

  Widget _weatherInfoTile(
      {Icon icon, Color iconBackground, Text title, Text description, double padding}) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: iconBackground),
              child: icon),
          SizedBox(
            width: padding,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[title, description],
          ),
        ]);
  }
}

enum sunMode { SUNSET, SUNRISE }
