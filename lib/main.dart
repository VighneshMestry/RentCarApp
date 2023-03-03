import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rent_car_app/model/car.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

final currentCar = carList.cars[0];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
          padding: const EdgeInsets.only(left: 25),
          child: const Icon(Icons.arrow_back),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 25),
            child: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: const LayoutStart(),
    );
  }
}

class LayoutStart extends StatelessWidget {
  const LayoutStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        CarDetailsAnimation(),
        _CustomBottomSheet(),
      ],
    );
  }
}

class CarDetailsAnimation extends StatefulWidget {
  const CarDetailsAnimation({super.key});

  @override
  State<CarDetailsAnimation> createState() => _CarDetailsAnimationState();
}

class _CarDetailsAnimationState extends State<CarDetailsAnimation> {
  @override
  Widget build(BuildContext context) {
    return const CarDetails();
  }
}

class CarDetails extends StatelessWidget {
  const CarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 30),
          child: _carTitle(),
        ),
        const CarCarousel()
      ],
    );
  }

  _carTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.white, fontSize: 38),
            children: [
              TextSpan(text: currentCar.companyName),
              const TextSpan(text: "\n"),
              TextSpan(
                  text: currentCar.carName,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16),
            children: [
              TextSpan(
                text: currentCar.price.toString(),
                style: TextStyle(
                  color: Colors.grey[20],
                ),
              ),
              const TextSpan(
                text: " / day",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        )
      ],
    );
  }
}

class CarCarousel extends StatefulWidget {
  const CarCarousel({super.key});

  @override
  State<CarCarousel> createState() => _CarCarouselState();
}

class _CarCarouselState extends State<CarCarousel> {
  static final List<String> imgList = currentCar.imgList;
  // final List<Widget> child = _map<Widget>(imgList, (index, String assetName) {
  //   return Container(
  //       child: Image.asset("assets/$assetName", fit: BoxFit.fitWidth));
  // }).toList();

  // static List<T> _map<T>(List list, Function handler) {
  //   List<T> result = [];
  //   for (var i = 0; i < list.length; i++) {
  //     result.add(handler(i, list[i]));
  //   }
  //   return result;
  // }
  late int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 252,
          child: PageView.builder(
            controller: PageController(viewportFraction: 1.0),
            itemCount: imgList.length,
            onPageChanged: (index) {
              setState(() {
                _current = index;
                log(_current.toString());
              });
            },
            itemBuilder: (_, i) {
              return Column(
                children: [
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage(imgList[i]), fit: BoxFit.fitWidth),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < imgList.length; i++)
              if (i == _current)
                Container(
                  margin: const EdgeInsets.only(right: 2),
                  width: 50,
                  height: 2,
                  decoration: BoxDecoration(color: Colors.grey[100]),
                )
              else
                Container(
                  margin: const EdgeInsets.only(right: 2),
                  width: 50,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                  ),
                )
          ],
        ),
      ],
    );
  }
}

class _CustomBottomSheet extends StatefulWidget {
  const _CustomBottomSheet({super.key});

  @override
  State<_CustomBottomSheet> createState() => __CustomBottomSheetState();
}

class __CustomBottomSheetState extends State<_CustomBottomSheet> {
  double sheetTop = 400;
  double minSheetTop = 100;

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: sheetTop,
      left: 0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded ? sheetTop = 400 : sheetTop = minSheetTop;
            isExpanded = !isExpanded;
          });
        },
        child: SheetContainer(),
      ),
    );
  }
}

class SheetContainer extends StatelessWidget {
  const SheetContainer({super.key});

  @override
  Widget build(BuildContext context) {
    double sheetItemHeight = 110;

    return Container(
        padding: const EdgeInsets.only(top: 25),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
          color: Color(0xfff1f1f1),
        ),
        child: Column(
          children: [
            drawerHandle(),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  offerDetails(sheetItemHeight),
                  specifications(sheetItemHeight),
                  features(sheetItemHeight),
                  const SizedBox(
                    height: 220,
                  ),
                ],
              ),
            )
          ],
        ));
  }

  drawerHandle() {
    return Container(
        height: 3,
        width: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[400],
        ));
  }

  specifications(sheetItemHeight) {
    return Container(
        padding: const EdgeInsets.only(top: 15, left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Specifications",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: sheetItemHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: currentCar.specifications.length,
                itemBuilder: (_, i) {
                  return ListItem(
                    sheetItemHeight: sheetItemHeight,
                    mapVal: currentCar.specifications[i],
                  );
                },
              ),
            )
          ],
        ));
  }

  features(double sheetItemHeight) {
    return Container(
        padding: const EdgeInsets.only(top: 15, left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Feautres",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: sheetItemHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: currentCar.features.length,
                itemBuilder: (_, i) {
                  return ListItem(
                    sheetItemHeight: sheetItemHeight,
                    mapVal: currentCar.features[i],
                  );
                },
              ),
            )
          ],
        ));
  }

  offerDetails(double sheetItemHeight) {
    return Container(
        padding: const EdgeInsets.only(top: 15, left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Offer Details",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: sheetItemHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: currentCar.offerDetails.length,
                itemBuilder: (_, i) {
                  return ListItem(
                    sheetItemHeight: sheetItemHeight,
                    mapVal: currentCar.offerDetails[i],
                  );
                },
              ),
            )
          ],
        ));
  }
}

class ListItem extends StatelessWidget {
  final double sheetItemHeight;
  final Map mapVal;

  const ListItem(
      {super.key, required this.mapVal, required this.sheetItemHeight});

  @override
  Widget build(BuildContext context) {
    var innerMap;
    bool isMap;

    if (mapVal.values.elementAt(0) is Map) {
      innerMap = mapVal.values.elementAt(0);
      isMap = true;
    } else {
      innerMap = mapVal;
      isMap = false;
    }

    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: sheetItemHeight,
      height: sheetItemHeight,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          mapVal.keys.elementAt(0),
          isMap
              ? Text(
                  innerMap.keys.elementAt(0),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black, letterSpacing: 1.2, fontSize: 11),
                )
              : Container(),
          Text(
            innerMap.values.elementAt(0),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
