import 'package:flutter/material.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/database_handler/city.dart';
import 'package:weather/view_models/database_handler/database_handler.dart';
import 'package:weather/views/search_view/widgets/result_card.dart';

class SearchViewVertical extends StatefulWidget {
  ScrollController _controller;
  DatabaseHandler databaseHandler;

  SearchViewVertical(this._controller, this.databaseHandler);

  @override
  _SearchViewVerticalState createState() =>
      _SearchViewVerticalState(_controller, databaseHandler);
}

class _SearchViewVerticalState extends State<SearchViewVertical> {
  bool onTyping = false;
  bool clearTapped = true;
  ScrollController _controller;
  DatabaseHandler databaseHandler;
  TextEditingController textController = TextEditingController();
  List<City> result = [];

  List<Widget> cityCards = [];

  int size = 10;

  List<Widget> fillCards() {
    int newSize = result.length > 10 ? size : result.length;
    cityCards = List.generate(newSize, (index) {
      return buildResultCard(result[index], context, _controller);
    });
    print(cityCards.length);
    return cityCards;
  }

  _SearchViewVerticalState(this._controller, this.databaseHandler) {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: device.width,
        height: device.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffE7FFFA), Color(0xffF1FFFC)],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Container(
                    width: device.width - 50,
                    height: device.height / 10,
                    child: TextFormField(
                      controller: textController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      onEditingComplete: () {
                        setState(() {
                          onTyping = false;
                        });
                      },
                      onTap: () {
                        setState(() {
                          onTyping = !onTyping;
                        });
                      },
                      decoration: InputDecoration(
                          suffixIcon: textController.text.length != 0
                              ? IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    textController.text = "";
                                    clearTapped = true;
                                    setState(() {
                                      result.clear();
                                    });
                                  },
                                )
                              : Icon(Icons.clear, color: Colors.transparent),
                          focusColor: Colors.red,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          prefixIcon: IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.blue,
                            onPressed: () {
                              if (textController.text.isNotEmpty)
                                result =
                                    databaseHandler.query(textController.text);
                              if (result.isEmpty) clearTapped = false;
                            },
                          ),
                          hintText:
                              "${AppLocalizations.of(context).translate("search")}..."),
                    ),
                  ),
                ),
                Container(
                  width: device.width,
                  height: device.height / 1.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      controller: _controller,
                      child: result.length != 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: fillCards(),
                                  ),
                                  size > 10
                                      ? GestureDetector(
                                          child: Text("Tap to More..."),
                                          onTap: () {
                                            setState(
                                              () {
                                                size = size + 10;
                                                fillCards();
                                              },
                                            );
                                          },
                                        )
                                      : Container()
                                ])
                          : clearTapped
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

  @override
  void dispose() {
    textController.text = "";
    result.clear();
  }
}
