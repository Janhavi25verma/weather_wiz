import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable{}

class FetchWeather extends WeatherEvent {
  final String city;
  final String country;

  FetchWeather({required this.city, required this.country});

  @override
  List<Object?> get props => [city,country];
}
