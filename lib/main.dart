import 'package:flutter/material.dart';
import 'led_light_control.dart';
import 'package:desktop_window/desktop_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Size size = await DesktopWindow.getWindowSize();
  print(size);
// setting min and max with the same size to prevent resizing
  await DesktopWindow.setMinWindowSize(const Size(900, 700));
  await DesktopWindow.setMaxWindowSize(const Size(1920, 1080));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Led Light Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
