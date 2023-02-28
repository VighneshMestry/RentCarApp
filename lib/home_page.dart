import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rent_car_app/common/info_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List infoCardList = ["first", "second", "third", "", "", ""];
    return SafeArea(
      child: Scaffold(
        backgroundColor:  Colors.grey[100],
        body: Container(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const Text("Offer Details", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24),),
                 const SizedBox(height: 20,),
                 SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                   child: Row(
                    children: [
                      for(final infoCard in infoCardList) 
                        InforCard(text: infoCard),
                    ],
                   ),
                 )
                 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
