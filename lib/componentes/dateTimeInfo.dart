import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeInfo extends StatelessWidget {
  final weather;
  final String areaInfo;
  const DateTimeInfo({super.key, this.weather, required this.areaInfo});

  @override
  Widget build(BuildContext context) {

    DateTime now = weather;
    return Column(
      children: [
        Text(areaInfo,
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontSize: 35,
              ),
            ),
            Text(
              " ${DateFormat("dd.MM.yyyy").format(now)}",
              style: const TextStyle(
                fontSize: 35,
              ),
            ),
          ],
        )
      ],
    );
  }
}
