import 'package:flutter/material.dart';

class WeatherLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xF3A683FF)),
        backgroundColor: Color(0xF19066FF),
      ),
    );
  }
}
