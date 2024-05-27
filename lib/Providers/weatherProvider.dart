import 'package:flutter/cupertino.dart';
import 'package:weather/weather.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? _weather;

  Weather? get weather => _weather;

  void setWeather(Weather? weather) {
    _weather = weather;
    notifyListeners();
  }
}
