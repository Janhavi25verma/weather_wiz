import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_information_item.dart';
import 'package:weather_app/hidden.dart';
import 'package:weather_app/hourly_weather_card.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<Map<String,dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final result = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherApiKey'),
      );
      final data = jsonDecode(result.body);
      if (data['cod']!='200') {
        throw ("Unexpected error occurred");
      }
      // print(data['list'][0]['main']['temp']);
      return data;
    } catch (e) {
      throw e.toString();
    }
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather() ,
        builder: (context,snapshot) {
          print(snapshot);
       if(snapshot.connectionState == ConnectionState.waiting){
         return const Center(child: CircularProgressIndicator());
       }
       if(snapshot.hasError){
         return Text(snapshot.error.toString());
       }
        final data= snapshot.data!;
       final currentTemp= data['list'][0]['main']['temp'];
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
                      child:  Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              "$currentTemp°K",
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Icon(
                              Icons.cloud,
                              size: 30,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Rain",
                              style: TextStyle(fontSize: 20),
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
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HourlyWeatherCard(
                      time: "8:00",
                      weatherAtTime: "Rain",
                      icon: Icons.cloudy_snowing,
                    ),
                    HourlyWeatherCard(
                      time: "10:00",
                      weatherAtTime: "Thunder",
                      icon: Icons.thunderstorm,
                    ),
                    HourlyWeatherCard(
                      time: "12:00",
                      weatherAtTime: "Cloudy",
                      icon: Icons.cloud,
                    ),
                    HourlyWeatherCard(
                      time: "14:00",
                      weatherAtTime: "Rain",
                      icon: Icons.cloudy_snowing,
                    ),
                    HourlyWeatherCard(
                      time: "17:00",
                      weatherAtTime: "Thunder",
                      icon: Icons.thunderstorm,
                    ),
                    HourlyWeatherCard(
                      time: "19:00",
                      weatherAtTime: "Cloudy",
                      icon: Icons.cloud,
                    ),
                    HourlyWeatherCard(
                      time: "21:00",
                      weatherAtTime: "Cloudy",
                      icon: Icons.cloud,
                    ),
                  ],
                ),
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInformationItem(
                    icon: Icons.water_drop,
                    label: "Humidity",
                    value: 97,
                  ),
                  AdditionalInformationItem(
                    icon: Icons.air,
                    label: "Wind Speed",
                    value: 30,
                  ),
                  AdditionalInformationItem(
                    icon: Icons.beach_access,
                    label: "Pressure",
                    value: 97,
                  ),
                ],
              ),
            ],
          ),
        );
        },
      ),
    );
  }
}
