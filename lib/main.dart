import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/location/location_bloc.dart';
import 'package:weather_app/screen/location_screen.dart';
import 'package:weather_app/screen/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp  extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(useMaterial3: true),
    home: BlocProvider(
        create: (context) => LocationBloc(),
        child: const LocationScreen()),
    );
  }
}
