import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  double color_of_inside_pot = 39;
  Color led_color = Colors.red;
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
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.grey),
          padding: const EdgeInsets.all(8),
          child: Stack(children: [
            Align(
              alignment: const Alignment(0, 0),
              child: Container(
                width: 600,
                height: 600,
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment(0, 0),
                      child: Image(
                        image: AssetImage('assets/image/circut.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 196,
                      right: 145,
                      child: potensiometer(),
                    ),
                    Align(
                      alignment: const Alignment(0.785, -0.15),
                      child: led(
                          led_shadow_color: led_shadow_color,
                          led_color: led_color),
                    ),
                    Align(
                      alignment: Alignment(0, 0.5),
                      child: ElevatedButton(
                          onPressed: (() {}),
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
                initialValue: 255,
                innerWidget: (percentage) {
                  return Stack(
                    children: [
                      Align(
                        alignment: const Alignment(0, -0.3),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(angle / 360),
                          child: Container(
                            alignment: Alignment.centerRight,
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
                                  color: Colors.red,
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
                    angle = (value.ceil().toInt() ~/ 1.416666) + 180;
                    pot_num.text = value.ceil().toString();
                  });
                  print(value);
                })),
      ],
    );
  }
}

class led extends StatelessWidget {
  const led({
    Key? key,
    required this.led_shadow_color,
    required this.led_color,
  }) : super(key: key);

  final Color led_shadow_color;
  final Color led_color;

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
        color: led_color,
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
