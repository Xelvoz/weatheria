import 'package:flutter/material.dart';

class WeatherError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
