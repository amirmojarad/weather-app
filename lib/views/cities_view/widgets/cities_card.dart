import 'package:flutter/material.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/database_handler/city.dart';

class CitiesCard extends StatefulWidget {
  City city;
  Function function;
  bool isSelected;
  CitiesCard(this.city, this.function, this.isSelected);

  @override
  _CitiesCardState createState() => _CitiesCardState(this.city, this.function, this.isSelected);
}

class _CitiesCardState extends State<CitiesCard> {
  City city;
  bool homeSelected;
  Function function;

  _CitiesCardState(this.city, this.function, this.homeSelected);

  BorderRadius borderRadius = BorderRadius.only(
    topLeft: Radius.circular(2),
    topRight: Radius.circular(30),
    bottomLeft: Radius.circular(30),
    bottomRight: Radius.circular(2),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff61DDFF),
          borderRadius: borderRadius,
          gradient: LinearGradient(
            colors: [
              Color(0xff04E6FF),
              Color(0xff3AEBFF),
              Color(0xff71F1FF),
              Color(0xffADF7FF),
            ],
          ),
        ),
        width: device.width,
        height: 120,
        child: Material(
          borderRadius: borderRadius,
          color: Colors.transparent,
          child: InkWell(
            splashColor: Color(0xffDAF7FF),
            borderRadius: borderRadius,
            onTap: () {},
            child: AspectRatio(
              aspectRatio: 1.1,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 15),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          city.city,
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(city.country,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () async {
                                setState(() {
                                  homeSelected = !homeSelected;
                                });
                                await function();
                              },
                              child: Icon(
                                  homeSelected
                                      ? Icons.home
                                      : Icons.home_outlined,
                                  size: 35),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
