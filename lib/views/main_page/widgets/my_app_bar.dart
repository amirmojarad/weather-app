import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff04C0EA),
      elevation: 20,
      title: Text("Weather App",
          style: TextStyle(color: Colors.white.withOpacity(0.9))),
    );
  }
}
