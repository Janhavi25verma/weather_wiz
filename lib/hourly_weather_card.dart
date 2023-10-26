import 'package:flutter/material.dart';

class HourlyWeatherCard extends StatelessWidget {
  final String time;
  final IconData icon;
 final String weatherAtTime;

 const HourlyWeatherCard(
      {super.key,
      required this.time,
      required this.icon,
      required this.weatherAtTime});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 16),
              ),
            const  SizedBox(
                height: 10,
              ),
              Icon(
                icon,
                size: 20,
              ),
             const SizedBox(
                height: 10,
              ),
              Text(
                weatherAtTime,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
