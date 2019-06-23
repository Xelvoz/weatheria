import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:weatheria/models/weather.dart';
import 'package:weatheria/redux/appstate.dart';

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
              colors: [Colors.deepOrangeAccent, Colors.amberAccent])),
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: StoreConnector<AppState, Weather>(
          distinct: true,
            converter: (store) => store.state.weatherState,
            builder: (context, weather) => Column(
                  children: <Widget>[_displayWeatherInfo(context, weather)],
                )),
      ),
    );
  }

  Widget _displayWeatherInfo(BuildContext context, Weather weather) {
    if (StoreProvider.of<AppState>(context).state.weatherLoadingError) {
      return Center(
        child: Text("Uh-oh... Something went wrong..."),
      );
    } else {
      return (weather == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Text(weather.temperature.temp.toString()),
            ));
    }
  }
}
