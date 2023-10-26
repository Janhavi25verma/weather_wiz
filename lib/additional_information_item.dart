import 'package:flutter/material.dart';
class AdditionalInformationItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  const AdditionalInformationItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Icon(icon, size: 30,),
        const SizedBox(height: 10,),
        Text(label, style: const TextStyle(fontSize: 16),),
        const SizedBox(height: 10,),
        const Text("94", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
      ],
    );
  }
}