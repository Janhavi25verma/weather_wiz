import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<GetLocation>(_onGetLocation);
  }

  Future<void> _onGetLocation(GetLocation event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      Position position = await _determinePosition();
      final lat = position.latitude;
      final long = position.longitude;
      final placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        final place = placemarks[0];
        final city = place.locality ?? "";
        final street = place.street ?? "";
        final country = place.country?? "";
        emit(LocationLoaded(latitude: lat, longitude: long, city: city, street: street,country: country));
      } else {
        emit(LocationError(message: 'No address found'));
      }
    } catch (e) {
      emit(LocationError(message: e.toString()));
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw ('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw ('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw ('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

}
