import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screen/weather_screen.dart';
import '../bloc/location/location_bloc.dart';
import '../bloc/location/location_event.dart';
import '../bloc/location/location_state.dart';
import '../bloc/weather/weather_bloc.dart';
import '../bloc/weather/weather_event.dart';


class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location and Weather'),
      ),
      body: Center(
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationInitial) {
              return const Text("Press the button to get location");
            } else if (state is LocationLoading) {
              return const CircularProgressIndicator();
            } else if (state is LocationLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Latitude: ${state.latitude}, Longitude: ${state.longitude}'),
                  Text('City: ${state.city}, Street: ${state.street}, Country: ${state.country}'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WeatherBloc>().add(FetchWeather(city: state.city, country: state.country));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  WeatherScreen(city: state.city,
                            country: state.country,
                          lat: state.latitude,
                          lon: state.longitude),
                        ),
                      );
                    },
                    child: const Text('Get Weather'),
                  ),
                  // Display weather information here
                ],
              );
            } else if (state is LocationError) {
              return Text('Error: ${state.message}');
            } else {
              return const Text('Unknown state');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<LocationBloc>().add(GetLocation());
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
