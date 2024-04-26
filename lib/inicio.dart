import 'package:app_climatico/predictions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'const.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY,language: Language.PORTUGUESE_BRAZIL);


  Weather? _weather;
  final _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeatherForCity("Palmas");
  }

  void _fetchWeatherForCity(String city) async {
    try {
      final weather = await _wf.currentWeatherByCityName(city);
      setState(() {
        _weather = weather;
      });
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
    if (_weather == null) {
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
              _locationHeader(),
              const SizedBox(
                height: 20,
              ),
              _dateTimeInfo(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
              ),
              _weatherIcon(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              _currentTemp(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              _extraInfo(),
            ],
          ),
        ),
        Positioned(
          top: 30,
          right: 40,
          child: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PredictionPage(weather: _weather)));
            },
            icon: const Icon(
              Icons.calendar_today,
              size: 35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _locationHeader(){
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.60,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: "Digite o nome da cidade",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _fetchWeatherForCity(_cityController.text);
              print(_weather?.areaName);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.deepPurpleAccent,
              elevation: 0,
            ),
            child: const Icon(
              Icons.search,
              size: 35,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );


  }

  Widget _dateTimeInfo(){
    DateTime now = _weather!.date!;

    return Column(
      children: [
        Text(DateFormat("h:mm a").format(now),
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

  Widget _weatherIcon(){
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
                      "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"
                  ),
              ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),

      ],
    );
    }

  Widget _currentTemp() {
    return Text(
        "${_weather?.temperature?.celsius?.toStringAsFixed(0)}º C",
      style: const TextStyle(
        fontSize: 90,
      ),
    );
  }

  Widget _extraInfo(){
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "Maxima: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}º C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "Mínima: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}º C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),

            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Vel.Vento: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "Umidade: ${_weather?.humidity?.toStringAsFixed(0)} %",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


}
