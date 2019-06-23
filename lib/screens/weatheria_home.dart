import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weatheria/redux/appstate.dart';
import 'package:weatheria/screens/weather_icons.dart';

class WeatheriaHome extends StatefulWidget {
  @override
  _WeatheriaHomeState createState() => _WeatheriaHomeState();
}

class _WeatheriaHomeState extends State<WeatheriaHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Colors.deepOrangeAccent[100], Colors.amberAccent[100]])),
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: StoreConnector<AppState, AppState>(
            distinct: true,
            converter: (store) => store.state,
            builder: (context, state) => Column(
                  children: <Widget>[
                    Expanded(child: _displayWeatherInfo(context, state))
                  ],
                )),
      ),
    );
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
            mainAxisAlignment: MainAxisAlignment.start,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "${state.weatherState.temperature}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 70, color: Colors.white70),
                  ),
                  Container(width: 1, height: 60, decoration: BoxDecoration(color: Colors.white70),),
                  Icon(WeatherIcons.sun_inv, size: 60, color: Colors.white70,)
                ],
              )
            ],
          ),
        );
      }
    }
  }
}
