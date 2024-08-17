import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/places/places_event.dart';
import 'package:weather_app/bloc/places/places_state.dart';
import '../../service/places_service.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlacesService placesService;

  PlaceBloc(this.placesService) : super(PlaceInitial()) {
    on<FetchPlaces>(_onFetchPlaces);
  }

  Future<void> _onFetchPlaces(FetchPlaces event, Emitter<PlaceState> emit) async {
    emit(PlaceLoading());
    try {
      final suggestionType = event.weatherCondition.contains('Rain') ? 'indoor' : 'outdoor';
      final placeType = suggestionType == 'indoor'
          ? 'museum|shopping_mall|movie_theater|restaurant'
          : 'park|picnic_area';

      final places = await placesService.fetchPlaces(event.lat, event.lon, placeType);
      emit(PlaceLoaded(places, suggestionType));
    } catch (e) {
      emit(PlaceError(e.toString()));
    }
  }
}
