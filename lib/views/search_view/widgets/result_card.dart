import 'package:flutter/material.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/cities_handler/cities_handler.dart';
import 'package:weather/view_models/controllers/search_result_card_controller.dart';
import 'package:weather/view_models/database_handler/city.dart';
import 'package:weather/view_models/home_city/home_city.dart';
import 'package:weather/views/city_view/resultCity.dart';
import 'package:weather/views/utils/my_flutter_app_icons.dart';

class ResultCard extends StatelessWidget {
  City city;
  CitiesHandler citiesHandler;
  ScrollController _controller;
  HomeCity homeCity;
  SearchResultCardController controller;
  Function setState;
  bool selected = false;

  ResultCard(this.city, this.citiesHandler, this.homeCity, this.setState) {
    controller = SearchResultCardController();
    controller.city = city;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).backgroundColor,
            ),
            width: device.width,
            height: device.height / 10,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FutureBuilder(
                      future: controller.getData(),
                      builder: (context, snapshot) => snapshot.hasData
                          ? ResultCity(snapshot.data['widget'], () async {
                        homeCity.changeHome(snapshot.data['weather']);
                        await homeCity.saveHome();
                      })
                          : Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.white,
                          child:
                          Center(child: CircularProgressIndicator())),
                    ),
                  ),
                );
              },
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.city.city,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          controller.city.country,
                          style: Theme.of(context).textTheme.bodyText1,
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
                            controller.addToFavorites(citiesHandler);
                            await citiesHandler.save();
                            setState();
                          },
                          child: controller.likeTapped
                              ? Icon(MyFlutterApp.like,
                                  color: Colors.red, size: 30)
                              : Icon(MyFlutterApp.like, size: 30),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: device.width,
              child: Divider(color: Color(0xffdddddd)),
            ),
          ),
        ],
      ),
    );
  }
}

// class ResultCard extends StatefulWidget {
//
//
//   ResultCard(this.city, this._controller, this.citiesHandler, this.homeCity);
//
//   @override
//   _ResultCardState createState() => _ResultCardState(city, this._controller);
// }
//
// class _ResultCardState extends State<ResultCard> {
//
//
//   _ResultCardState(City city, ScrollController scrollController) {
//     controller =
//         SearchResultCardController(controller: scrollController, city: city);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
//
// }
