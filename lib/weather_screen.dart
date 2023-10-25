import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
      body: Padding(
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
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            "300°K",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.cloud,
                            size: 30,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
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
                  HourlyWeatherCard(),
                  HourlyWeatherCard(),
                  HourlyWeatherCard(),
                  HourlyWeatherCard(),
                  HourlyWeatherCard(),
                  HourlyWeatherCard(),

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
             children: [
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 45),
                 child: Column(
                   children: [
                     Icon(Icons.water_drop,size: 30,),
                     SizedBox(height: 10,),
                     Text("Humidity",style: TextStyle(fontSize: 16),),
                     SizedBox(height: 10,),
                     Text("94",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                   ],
                 ),
               ),
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 45),
                 child: Column(
                   children: [
                     Icon(Icons.air,size: 30,),
                     SizedBox(height: 10,),
                     Text("Wind Speed",style: TextStyle(fontSize: 16),),
                     SizedBox(height: 10,),
                     Text("97",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                   ],
                 ),
               ),
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 45),
                 child: Column(
                   children: [
                     Icon(Icons.umbrella,size: 30,),
                     SizedBox(height: 10,),
                     Text("Pressure",style: TextStyle(fontSize: 16),),
                     SizedBox(height: 10,),
                     Text("94",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                   ],
                 ),
               )
             ],
           )
          ],
        ),
      ),
    );
  }
}

class HourlyWeatherCard extends StatelessWidget {
  const HourlyWeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Padding(
          padding: EdgeInsets.all(8.0),

          child: Column(
            children: [
              Text(
                "9:00",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Icon(
                Icons.cloud,
                size: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Rain",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

