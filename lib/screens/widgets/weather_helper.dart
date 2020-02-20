import 'package:flutter/material.dart';

class WeatherHelper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
