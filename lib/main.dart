import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/screens/home/home_page.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.green, fontFamily: "Poppins"),
          home: HomePage(),
        );
      },
    );
  }
}
