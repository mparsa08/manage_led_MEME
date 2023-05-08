import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int angle = 0;
  double lightness = 0.5;
  double color_green = 120;
  double color_red = 0;
  double color_yellow = 51;
  double color_orange = 39;
  double color_blue = 210;
  double color_of_light = 210;
  final double? _pot_width = 150;
  final double? _pot_hight = 150;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.grey),
          padding: EdgeInsets.all(8),
          child: Stack(children: [
            potensiometer(),
          ]),
        ),
      ),
    ));
  }

  Positioned potensiometer() {
    return Positioned(
        bottom: 0,
        right: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                width: _pot_width,
                height: _pot_hight,
                child: SleekCircularSlider(
                    innerWidget: (percentage) {
                      return Stack(
                        children: [
                          Align(
                            alignment: const Alignment(0, -0.3),
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation(angle / 360),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: (_pot_width! - 100),
                                height: (_pot_width! - 100),
                                decoration: BoxDecoration(
                                  color: HSLColor.fromAHSL(
                                          1, color_of_light, 1, lightness)
                                      .toColor(),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                    width: 20,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(200)),
                                    )),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment(0, 1),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                color: Colors.amber,
                              ),
                              child: Text(
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                percentage.ceil().toString(),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    max: 255,
                    appearance: CircularSliderAppearance(
                        size: 100,
                        customColors: CustomSliderColors(
                          progressBarColors: [Colors.red, Colors.green],
                        ),
                        startAngle: 180,
                        angleRange: 180),
                    onChange: (double value) {
                      setState(() {
                        angle = value.ceil().toInt() ~/ 1.416666;
                      });
                      print(value);
                    })),
          ],
        ));
  }
}
