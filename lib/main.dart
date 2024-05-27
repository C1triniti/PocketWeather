import 'package:app_climatico/Telas/weather_map.dart';
import 'package:app_climatico/const.dart';
import 'package:app_climatico/Telas/predictions.dart';
import 'package:app_climatico/Providers/weatherProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'Telas/inicio.dart';


void main() {
  Intl.defaultLocale = 'pt_Br';
  initializeDateFormatting('pt_Br', null);
  runApp(ChangeNotifierProvider<WeatherProvider>( // Wrap MyApp with Provider
    create: (context) => WeatherProvider(), // Create WeatherProvider instance
    child: const MyApp(),
  ),);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const PredictionPage(),
    const MapSample(),
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkMode,
      home: Scaffold(
          bottomNavigationBar: NavigationBar(
            height: 50,
            selectedIndex: index,
            onDestinationSelected: (index){
              setState(() {
                this.index = index;
              });
            },
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home),
                  label: "Inicio"
              ),
              NavigationDestination(
                  icon: Icon(Icons.calendar_month),
                  label: "Previsões"
              ),
              NavigationDestination(
                  icon: Icon(Icons.map),
                  label: "Maps"
              ),
            ],
          ),
          body: _pages[index]
      ),
    );
  }
}
