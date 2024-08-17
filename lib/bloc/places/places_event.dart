import 'package:equatable/equatable.dart';

abstract class PlaceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPlaces extends PlaceEvent {
  final double lat;
  final double lon;
  final String weatherCondition;

  FetchPlaces(this.lat, this.lon, this.weatherCondition);

  @override
  List<Object?> get props => [lat, lon, weatherCondition];
}
