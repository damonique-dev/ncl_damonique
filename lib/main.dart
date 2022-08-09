import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:ncl_damonique/blocs/bloc/cruise_ship_bloc.dart';
import 'package:ncl_damonique/screens/home_screen.dart';
import 'package:ncl_damonique/services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NCL Cruise Ships',
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: BlocProvider(
          create: (_) => CruiseShipBloc(ApiService(http.Client())),
          child: const HomeScreen()),
    );
  }
}
