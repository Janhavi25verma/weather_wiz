import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_information_item.dart';
import 'package:weather_app/hidden.dart';
import 'package:weather_app/hourly_weather_card.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl_browser.dart';

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

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final result = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherApiKey'),
      );
      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
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
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          final data = snapshot.data!;
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
                                "$currentTemp°K",
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
                      itemCount:8,
                      itemBuilder: (context, index) {
                        final hourlyForecast = data['list'][index];
                        final hourlyIcon = data['list'][index]['weather'][0]['main'];
                        return HourlyWeatherCard(
                            time: hourlyForecast['dt'].toString(),
                            icon: hourlyIcon == "Clouds" ? Icons.cloud : Icons
                                .cloudy_snowing,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
