import 'package:app_climatico/const.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';



class PredictionPage extends StatefulWidget {
  final Weather? weather;
  const PredictionPage({super.key, this.weather});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {

  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY,language: Language.PORTUGUESE_BRAZIL);
  List<Weather> forecast = [];

  @override
  void initState() {
    super.initState();
    _fetchForecast();
  }

  void _fetchForecast() async {
    final cityName = widget.weather?.areaName ?? "";
    forecast = await _wf.fiveDayForecastByCityName(cityName);
    print(forecast);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previsões"),
      ),
    );
  }
}




