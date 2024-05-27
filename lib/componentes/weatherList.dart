import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherList extends StatelessWidget {
  final Future<List<Weather>> future;
  const WeatherList({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Weather>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          final List<Weather> forecast = snapshot.data!;

          return ListView.builder(
            itemCount: forecast.length,
            itemBuilder: (context, index){
              final forecasts = forecast[index];
              final dateFormatter = DateFormat("dd/MM");

              return Padding(
                padding: const EdgeInsets.all(8.0),

                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Row(
                        children: [
                          Text(dateFormatter.format(forecasts.date!)),

                          const SizedBox(width: 10),

                          Text(DateFormat("h:mm a").format(forecasts.date!)),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Image.network(
                            "http://openweathermap.org/img/wn/${forecasts.weatherIcon}@4x.png",
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(width: 5),

                          Text(forecasts.weatherDescription ?? ""),
                        ],
                      ),
                      trailing: Text(
                          "${forecasts.tempMax?.celsius?.toStringAsFixed(0)}ºC",
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      )
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
