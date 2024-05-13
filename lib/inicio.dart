import 'package:app_climatico/weatherProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import 'componentes/dateTimeInfo.dart';
import 'componentes/locationHeader.dart';
import 'const.dart';
import 'componentes/extraInfo.dart';
import 'componentes/currentTemp.dart';
import 'componentes/weatherIcon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY,language: Language.PORTUGUESE_BRAZIL);
  final _cityController = TextEditingController();


  void _fetchWeatherForCity(String city) async {
    try {
      final weather = await _wf.currentWeatherByCityName(city);
      context.read<WeatherProvider>().setWeather(weather);

    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI(){
    final _weather = context.watch<WeatherProvider>().weather;
    if (_weather == null) {
      _fetchWeatherForCity("Palmas");
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),

              LocationHeader(
                controller: _cityController,
                onSearchPressed: () {
                  _fetchWeatherForCity(_cityController.text);
                },
              ),
              const SizedBox(
                height: 20,
              ),

              DateTimeInfo(
                weather: _weather.date!,
                areaInfo: "${_weather.areaName}, ${_weather.country}",
              ),

              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),

              WeatherIcon(
                networkImage: "http://openweathermap.org/img/wn/${_weather.weatherIcon}@4x.png",
                weatherDesc: _weather.weatherDescription ?? "",
              ),

              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),

              CurrentTemp(
                currentTemp: "${_weather.temperature?.celsius?.toStringAsFixed(0)}º C",
              ),

              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),

              ExtraInfo(
                maxTemp: "Maxima: ${_weather.tempMax?.celsius?.toStringAsFixed(0)}º C",
                minTemp: "Mínima: ${_weather.tempMin?.celsius?.toStringAsFixed(0)}º C",
                windSpeed: "Vel.Vento: ${_weather.windSpeed?.toStringAsFixed(0)} m/s",
                humidity: "Umidade: ${_weather.humidity?.toStringAsFixed(0)} %",
              ),

            ],
          ),
        ),
      ],
    );
  }
}
