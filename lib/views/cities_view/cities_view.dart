import 'package:flutter/material.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/cities_handler/cities_handler.dart';
import 'package:weather/view_models/controllers/cities_view_controller.dart';
import 'package:weather/view_models/database_handler/city.dart';

class CitiesView extends StatefulWidget {
  ScrollController controller;
  CitiesHandler citiesHandler;

  CitiesView(this.controller, this.citiesHandler);

  @override
  _CitiesViewState createState() => _CitiesViewState();
}

class _CitiesViewState extends State<CitiesView> {
  CitiesViewController controller = CitiesViewController();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print(widget.citiesHandler.cities.cities.length);
    return SafeArea(
      child: SingleChildScrollView(
        controller: widget.controller,
        child: widget.citiesHandler.cities.cities.length != 0
            ? Column(
                children: List.generate(
                    widget.citiesHandler.cities.cities.length, (index) {
                  return buildCityCard(
                      widget.citiesHandler.cities.cities[index]);
                }),
              )
            : Center(
                child: Text("List Is Empty"),
              ),
      ),
    );
  }

  Padding buildCityCard(City city) {
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(2),
      topRight: Radius.circular(30),
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(2),
    );

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      city.city,
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(city.country,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500)),
                    )
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
