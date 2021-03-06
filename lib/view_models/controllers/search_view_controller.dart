import 'package:flutter/material.dart';
import 'package:weather/view_models/cities_handler/cities_handler.dart';
import 'package:weather/view_models/database_handler/city.dart';
import 'package:weather/view_models/database_handler/database_handler.dart';
import 'package:weather/view_models/home_city/home_city.dart';
import 'package:weather/views/search_view/widgets/result_card.dart';

class SearchViewController {
  bool onTyping = false;
  bool clearTapped = true;
  ScrollController controller;
  DatabaseHandler databaseHandler;
  TextEditingController textController = TextEditingController();
  CitiesHandler citiesHandler;
  List<City> result = [];
  List<Widget> cityCards = [];
  int size = 10;
  HomeCity homeCity;

  SearchViewController(
      {this.controller,
      this.databaseHandler,
      this.citiesHandler,
      this.homeCity});

  List<Widget> fillCards(Function setState) {
    if (result.isEmpty) return [];
    int newSize = result.length > 10 ? size : result.length;
    cityCards = List.generate(newSize, (index) {
      return ResultCard(result[index], citiesHandler, homeCity, setState);
    });
    return cityCards;
  }

  void tapOnMore(Function setState) {
    size = size + 10;
    fillCards(setState);
  }

  void onSearchPressed() {
    if (textController.text.isNotEmpty)
      result = databaseHandler.query(textController.text);
    else
      cancelSearch();
    if (textController.text.isEmpty) return;
    if (result.isEmpty) clearTapped = false;
  }

  void onTap() {
    onTyping = !onTyping;
  }

  void onEditingComplete() {
    onTyping = false;
  }

  void cancelSearch() {
    textController.text = "";
    clearTapped = true;
    result.clear();
  }
}
