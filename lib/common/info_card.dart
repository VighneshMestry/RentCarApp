import 'package:flutter/material.dart';

class InforCard extends StatelessWidget {
  final String text;

  const InforCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: 120,
        width: 100,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_pin, size: 30,),
            const SizedBox(
              height: 20,
            ),
            Text(text, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
          ],
        ),
      ),
    );
  }
}
