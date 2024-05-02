import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String networkImage;
  final String weatherDesc;
  const WeatherIcon({super.key, required this.networkImage, required this.weatherDesc});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  networkImage,
              ),
            ),
          ),
        ),
        Text(
          weatherDesc,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),

      ],
    );
  }
}
