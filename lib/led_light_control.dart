import 'package:flutter/material.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int angle = 24;
  double lightness = 0.3;
  double color_green = 120;
  double color_red = 0;
  double color_yellow = 51;
  double color_orange = 39;
  double color_blue = 210;
  double color_of_inside_pot = 0;
  int led_color = 0;
  Color led_shadow_color = Colors.white;
  final double? _pot_width = 110;
  final double? _pot_hight = 110;
  TextEditingController pot_num = TextEditingController(text: '255');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 450,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.grey),
            padding: const EdgeInsets.all(8),
            child: Stack(children: [
              Align(
                alignment: const Alignment(0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 245, 246, 1),
                      borderRadius: BorderRadius.circular(20)),
                  width: 620,
                  height: 410,
                  child: Stack(
                    children: [
                      const Align(
                        alignment: Alignment(0, 0),
                        child: Image(
                          image: AssetImage('assets/image/circut.png'),
                          fit: BoxFit.cover,
                          width: 600,
                          height: 400,
                        ),
                      ),
                      Positioned(
                        top: 100,
                        right: 155,
                        child: potensiometer(),
                      ),
                      Align(
                        alignment: const Alignment(0.76, -0.22),
                        child: led(
                          led_shadow_color: led_shadow_color,
                          led_color: led_color,
                          led_lightness: lightness,
                        ),
                      ),
                      Align(
                        alignment: Alignment(0, 0.8),
                        child: ElevatedButton(
                            onPressed: (() {
                              var pot_number = int.parse(pot_num.text);

                              if (pot_number == 0) {
                                setState(() {
                                  lightness = 0.0;
                                  led_shadow_color = Colors.white;
                                });
                              } else if (pot_number <= 223 && pot_number > 0) {
                                setState(() {
                                  lightness = 0.3;
                                  led_shadow_color = Colors.white;
                                });
                              } else if (pot_number <= 236 &&
                                  pot_number > 223) {
                                setState(() {
                                  lightness = 0.4;
                                  led_shadow_color = Colors.white;
                                });
                              } else if (pot_number <= 245 &&
                                  pot_number > 236) {
                                setState(() {
                                  lightness = 0.5;
                                  led_shadow_color = Colors.white;
                                });
                              } else if (pot_number > 245) {
                                setState(() {
                                  lightness = 0.53;
                                  led_shadow_color = Colors.red;
                                });
                              }
                            }),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.play_circle_outline_sharp),
                                Text('RUN'),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    ));
  }

  Column potensiometer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            width: _pot_width,
            height: _pot_hight,
            child: SleekCircularSlider(
                initialValue: 50,
                innerWidget: (percentage) {
                  return Stack(
                    children: [
                      Align(
                        alignment: const Alignment(0, -0.3),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(angle / 360),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: (_pot_width! - 40),
                            height: (_pot_width! - 40),
                            decoration: BoxDecoration(
                              color: HSLColor.fromAHSL(
                                      1, color_of_inside_pot, 1, lightness)
                                  .toColor(),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                                width: 20,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(200)),
                                )),
                          ),
                        ),
                      ),
                      textfiledd(pot_num: pot_num),
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
                    angle = (value.ceil().toInt() ~/ 1.416666);
                    pot_num.text = value.ceil().toString();
                  });
                })),
      ],
    );
  }
}

class led extends StatelessWidget {
  const led(
      {Key? key,
      required this.led_shadow_color,
      required this.led_color,
      required this.led_lightness})
      : super(key: key);

  final Color led_shadow_color;
  final int led_color;
  final double led_lightness;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 30,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: led_shadow_color,
            offset: const Offset(
              5.0,
              3.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ), //BoxShadow
        ],
        color: HSLColor.fromAHSL(1, led_color.toDouble(), 1, led_lightness)
            .toColor(),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5)),
      ),
    );
  }
}

class textfiledd extends StatelessWidget {
  const textfiledd({
    Key? key,
    required this.pot_num,
  }) : super(key: key);

  final TextEditingController pot_num;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 1.3),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          width: 50,
          height: 20,
          alignment: Alignment.center,
          child: TextField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(width: 5)),
            ),
            keyboardType: TextInputType.number,
            textDirection: TextDirection.ltr,
            controller: pot_num,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
