import 'package:flutter/material.dart';
class AdditionalInformationItem extends StatelessWidget {
  const AdditionalInformationItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(Icons.water_drop, size: 30,),
        SizedBox(height: 10,),
        Text("Humidity", style: TextStyle(fontSize: 16),),
        SizedBox(height: 10,),
        Text("94", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
      ],
    );
  }
}