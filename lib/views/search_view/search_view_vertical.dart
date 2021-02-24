import 'package:flutter/material.dart';
import 'file:///D:/applications/AndroidProjects/weather_app/weather/lib/models/localizations/app_localizations.dart';
import 'package:weather/models/utils/device.dart';

class SearchViewVertical extends StatefulWidget {
  @override
  _SearchViewVerticalState createState() => _SearchViewVerticalState();
}

class _SearchViewVerticalState extends State<SearchViewVertical> {
  bool onTyping = false;

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
                          focusColor: Colors.red,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.blue),
                          hintText:
                              "${AppLocalizations.of(context).translate("search")}..."),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: device.width,
                    height: device.height - device.height / 10,
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
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
                              width: device.width - 100,
                              height: device.height / 6,
                              child: Material(
                                animationDuration: Duration(milliseconds: 50),
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(18),
                                  splashColor:
                                      Color(0xffD4FFE8).withOpacity(0.5),
                                  onTap: () {},
                                ),
                              ),
                            ),
                          );
                        }),
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
