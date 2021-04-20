import 'package:flutter/material.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/cities_handler/cities_handler.dart';
import 'package:weather/view_models/controllers/search_result_card_controller.dart';
import 'package:weather/view_models/database_handler/city.dart';
import 'package:weather/view_models/home_city/home_city.dart';

class ResultCard extends StatefulWidget {
  City city;
  CitiesHandler citiesHandler;
  ScrollController _controller;
  HomeCity homeCity;

  ResultCard(this.city, this._controller, this.citiesHandler, this.homeCity);

  @override
  _ResultCardState createState() => _ResultCardState(city, this._controller);
}

class _ResultCardState extends State<ResultCard> {
  SearchResultCardController controller;

  bool selected = false;

  _ResultCardState(City city, ScrollController scrollController) {
    controller =
        SearchResultCardController(controller: scrollController, city: city);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [
              Color(0xff36FF91),
              Color(0xff63FFA9),
              Color(0xff9CFFC8),
            ],
          ),
        ),
        width: device.width,
        height: device.height / 8,
        child: Material(
          animationDuration: Duration(milliseconds: 50),
          borderRadius: BorderRadius.circular(18),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            splashColor: Color(0xffD4FFE8).withOpacity(0.5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FutureBuilder(
                    future: controller.getData(),
                    builder: (context, snapshot) => snapshot.hasData
                        ? buildResultCity(snapshot, context)
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.white,
                            child: Center(child: CircularProgressIndicator())),
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: device.height / 50, left: device.width / 10),
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.city.city,
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                        SizedBox(height: 10),
                        Text(
                          controller.city.country,
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () async {
                            setState(() {
                              controller.addToFavorites(widget.citiesHandler);
                            });
                            await widget.citiesHandler.save();
                          },
                          child: Icon(
                              controller.likeTapped
                                  ? Icons.favorite
                                  : Icons.favorite_border_rounded,
                              color: controller.likeTapped
                                  ? Colors.red
                                  : Colors.black,
                              size: 30),
                        ),
                      ),
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

  Scaffold buildResultCity(AsyncSnapshot snapshot, BuildContext context) {
    return Scaffold(
      body: snapshot.data['widget'],
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child:
                  Icon(selected ? Icons.home : Icons.home_outlined, size: 30),
              onTap: () async {
                setState(() {
                  selected = !selected;
                  widget.homeCity.changeHome(snapshot.data['weather']);
                });
                await widget.homeCity.saveHome();
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
