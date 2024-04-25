import 'package:app_climatico/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'inicio.dart';


void main() {
  Intl.defaultLocale = 'pt_Br';
  initializeDateFormatting('pt_Br', null);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: darkMode,
    home: const HomePage(),
  ));
}
