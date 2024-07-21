import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final double latitude;
  final double longitude;
  final String city;
  final String street;
  final String country;

  LocationLoaded({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.street,
    required this.country,
  });

  @override
  List<Object> get props => [latitude, longitude, city, street,country];
}

class LocationError extends LocationState {
  final String message;

  LocationError({required this.message});

  @override
  List<Object> get props => [message];
}
