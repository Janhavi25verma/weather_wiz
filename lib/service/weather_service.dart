import 'dart:convert';
import 'package:http/http.dart' as http;
import '../components/hidden.dart';

Future<Map<String, dynamic>> fetchWeather(String city, String country) async {
  try {
    final result = await http.get(
      Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$city,$country&APPID=$openWeatherApiKey&units=metric'),
    );
    final data = jsonDecode(result.body);
    if (data['cod'] != '200') {
      throw ("Unexpected error occurred");
    }
    // print(data['list'][0]['main']['temp']);
    return data;
  } catch (e) {
    throw e.toString();
  }
}
