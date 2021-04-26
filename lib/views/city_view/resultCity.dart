import 'package:flutter/material.dart';
import 'package:weather/views/utils/my_flutter_app_icons.dart';

class ResultCity extends StatefulWidget {
  Widget mainScreen;
  Function changeHome;

  ResultCity(this.mainScreen, this.changeHome);

  @override
  _ResultCityState createState() => _ResultCityState();
}

class _ResultCityState extends State<ResultCity> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.mainScreen,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Icon(selected ? MyFlutterApp.home : MyFlutterApp.home,
                  size: 30),
              onTap: () async {
                setState(() {
                  selected = !selected;
                });
                await widget.changeHome();
                final snackBar = SnackBar(content: Text('Home Changed!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
