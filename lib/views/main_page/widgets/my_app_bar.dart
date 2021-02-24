import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffA7FFD0),
      elevation: 20,
      title: Text("Weather App",
          style: TextStyle(color: Colors.black.withOpacity(0.75))),
    );
  }
}
