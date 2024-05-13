import 'package:flutter/material.dart';

class CurrentTemp extends StatelessWidget {
  final String currentTemp;
  const CurrentTemp({super.key, required this.currentTemp});

  @override
  Widget build(BuildContext context) {
    return Text(
      currentTemp,
      style: const TextStyle(
        fontSize: 80,
      ),
    );
  }
}
