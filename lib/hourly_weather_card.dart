import 'package:flutter/material.dart';

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

