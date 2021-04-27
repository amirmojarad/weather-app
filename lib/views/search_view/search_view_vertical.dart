import 'package:flutter/material.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/cities_handler/cities_handler.dart';
import 'package:weather/view_models/controllers/search_view_controller.dart';
import 'package:weather/view_models/database_handler/database_handler.dart';
import 'package:weather/view_models/home_city/home_city.dart';
import 'package:weather/views/utils/my_flutter_app_icons.dart';

class SearchViewVertical extends StatefulWidget {
  ScrollController _controller;
  DatabaseHandler databaseHandler;
  CitiesHandler citiesHandler;
  HomeCity homeCity;

  SearchViewVertical(this._controller, this.databaseHandler, this.citiesHandler,
      this.homeCity);

  @override
  _SearchViewVerticalState createState() => _SearchViewVerticalState(
      _controller, databaseHandler, this.citiesHandler, this.homeCity);
}

class _SearchViewVerticalState extends State<SearchViewVertical> {
  SearchViewController controller;
  HomeCity homeCity;

  _SearchViewVerticalState(
      ScrollController scrollController,
      DatabaseHandler databaseHandler,
      CitiesHandler citiesHandler,
      HomeCity homeCity) {
    this.controller = SearchViewController(
        citiesHandler: citiesHandler,
        controller: scrollController,
        databaseHandler: databaseHandler,
        homeCity: homeCity);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: device.width,
        height: device.height,
        color: Theme.of(context).backgroundColor,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 16, right: 16),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 42.0),
                    child: Container(
                      width: device.width,
                      height: 48,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            controller.onSearchPressed();
                          });
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            controller.onSearchPressed();
                            FocusScope.of(context).requestFocus(FocusNode());
                          });
                        },
                        style: Theme.of(context).textTheme.headline5,
                        controller: controller.textController,
                        onEditingComplete: () {
                          setState(() {
                            controller.onEditingComplete();
                          });
                        },
                        onTap: () {
                          setState(() {
                            controller.onTap();
                          });
                        },
                        decoration: InputDecoration(
                            fillColor: Theme.of(context).accentColor,
                            contentPadding:
                                EdgeInsets.only(top: 12, bottom: 12, left: 52),
                            suffixIcon: controller.textController.text.length !=
                                    0
                                ? IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: Theme.of(context)
                                          .accentIconTheme
                                          .color,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        controller.cancelSearch();
                                      });
                                    },
                                  )
                                : Icon(Icons.clear, color: Colors.transparent),
                            focusColor: Colors.red,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(
                                  color: Theme.of(context).focusColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Theme.of(context).focusColor),
                            ),
                            prefixIcon: IconButton(
                              icon: Icon(MyFlutterApp.combined_shape_1),
                              color: Theme.of(context).iconTheme.color,
                              onPressed: () {
                                controller.onSearchPressed();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                            ),
                            hintText:
                                "${AppLocalizations.of(context).translate("search")}..."),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: device.width,
                  height: device.height / 1.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      controller: controller.controller,
                      child: controller.result.length != 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: controller.fillCards(() {
                                    setState(() {});
                                  }),
                                ),
                                controller.size > 10
                                    ? GestureDetector(
                                        child: Text("Tap to More..."),
                                        onTap: () {
                                          setState(
                                            () {
                                              controller.tapOnMore(() {
                                                setState(() {});
                                              });
                                            },
                                          );
                                        },
                                      )
                                    : Container()
                              ],
                            )
                          : controller.clearTapped
                              ? Container()
                              : Text("Not match anything"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
