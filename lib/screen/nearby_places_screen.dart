import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/places/places_bloc.dart';
import '../bloc/places/places_event.dart';
import '../bloc/places/places_state.dart';
import '../service/places_service.dart';

class PlaceScreen extends StatelessWidget {
  final double lat;
  final double lon;
  final String weatherCondition;

  const PlaceScreen({super.key, required this.lat, required this.lon, required this.weatherCondition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$weatherCondition Suggestions'),
      ),
      body: BlocProvider(
        create: (context) => PlaceBloc(PlacesService()) // Initialize PlaceBloc with PlacesService
          ..add(FetchPlaces(lat, lon, weatherCondition)),
        child: BlocBuilder<PlaceBloc, PlaceState>(
          builder: (context, state) {
            if (state is PlaceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlaceLoaded) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Suggestions for ${state.suggestionType} Activities',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.places.length,
                      itemBuilder: (context, index) {
                        final place = state.places[index];
                        return ListTile(
                          title: Text(place['name']),  // Adjust according to your data structure
                          subtitle: Text(place['vicinity']), // Adjust according to your data structure
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is PlaceError) {
              return Center(child: Text('Failed to fetch places: ${state.message}'));
            } else {
              return const Center(child: Text('No data'));
            }
          },
        ),
      ),
    );
  }
}
