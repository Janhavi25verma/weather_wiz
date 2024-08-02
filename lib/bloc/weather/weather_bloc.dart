// weather_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../service/weather_service.dart';
import 'weather_event.dart';
import 'weather_state.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  @override
  // Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
  //   if (event is FetchWeather) {
  //     yield WeatherLoading();
  //     try {
  //       final weatherData = await fetchWeather(event.city, event.country);
  //       yield WeatherLoaded(weatherData: weatherData);
  //     } catch (e) {
  //       yield WeatherError(message: e.toString());
  //     }
  //   }
  // }
  Future<void> _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weatherData = await fetchWeather(event.city, event.country);
      emit(WeatherLoaded(weatherData: weatherData));
    } catch (e) {
      emit(WeatherError(message: e.toString()));
    }
  }
}
