import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/additional_information_item.dart';
import 'package:weather_app/components/hourly_weather_card.dart';
import '../bloc/weather/weather_bloc.dart';
import '../bloc/weather/weather_event.dart';
import '../bloc/weather/weather_state.dart';
// import 'package:intl/intl_browser.dart';

class WeatherScreen extends StatefulWidget {
  final String city;
  final String country;

  const WeatherScreen({super.key, required this.city, required this.country});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;

  @override
  void initState() {
    super.initState();
    context
        .read<WeatherBloc>()
        .add(FetchWeather(city: widget.city, country: widget.country));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          // GestureDetector(child: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                setState(() {
                  context.read<WeatherBloc>().add(
                      FetchWeather(city: widget.city, country: widget.country));
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WeatherError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is WeatherLoaded) {
          final data = state.weatherData;
          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentPressure = currentWeatherData['main']['pressure'];
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //MAIN CARD
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 20,
                          sigmaY: 20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "$currentTemp °C",
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Icon(
                                currentSky == "Clouds" || currentSky == "Rain"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 30,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                currentSky,
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //HEADING2
                const Text(
                  "Weather Forecast",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                //SMALL CARD
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for(int i=1;i<=10;i++)
                //         HourlyWeatherCard(
                //         time: data['list'][i]['dt'].toString(),
                //         weatherAtTime: data['list'][i]['weather'][0]['main'].toString(),
                //         icon: data['list'][i]['weather'][0]['main']=="Clouds" ? Icons.cloud :Icons.cloudy_snowing ,
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        final hourlyForecast = data['list'][index];
                        final hourlyIcon =
                            data['list'][index]['weather'][0]['main'];
                        final time = DateTime.parse(hourlyForecast['dt_txt']);
                        return HourlyWeatherCard(
                            time: DateFormat.j().format(time),
                            icon: hourlyIcon == "Clouds"
                                ? Icons.cloud
                                : Icons.cloudy_snowing,
                            weatherAtTime: hourlyForecast['weather'][0]['main']
                                .toString());
                      }),
                ),
                const SizedBox(
                  height: 25,
                ),
                //ADDITIONAL INFORMATION
                const Text(
                  "Additional Information",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInformationItem(
                      icon: Icons.water_drop,
                      label: "Humidity",
                      value: currentHumidity.toDouble(),
                    ),
                    AdditionalInformationItem(
                      icon: Icons.air,
                      label: "Wind Speed",
                      value: currentWindSpeed.toDouble(),
                    ),
                    AdditionalInformationItem(
                      icon: Icons.beach_access,
                      label: "Pressure",
                      value: currentPressure.toDouble(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Planning to go out? ',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    children: [
                      TextSpan(
                        text: 'click here',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle the click event
                          },
                      ),
                      const TextSpan(
                        text: ' for suggestions near you.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return const Center(child: Text("No weather data available"));
        }
      }),
    );
  }
}
