import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable{
  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Map<String, dynamic> weatherData;

  WeatherLoaded({required this.weatherData});
  @override
  List<Object> get props => [weatherData];
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError({required this.message});
  @override
  List<Object> get props => [message];
}
