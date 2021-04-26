import 'package:flutter/material.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/controllers/cities_controller.dart';
import 'package:weather/view_models/database_handler/city.dart';
import 'package:weather/view_models/home_city/home_city.dart';
import 'package:weather/views/city_view/resultCity.dart';

import 'action_bottom_sheet.dart';

class CitiesCard extends StatelessWidget {
  HomeCity homeCity;
  City city;
  Function setAsDefault;
  Function delete;
  Function setMainState;
  BorderRadius borderRadius = BorderRadius.all(Radius.circular(12));
  CitiesController controller;

  CitiesCard(
      {this.city,
      this.setAsDefault,
      this.delete,
      this.setMainState,
      this.homeCity}) {
    controller = CitiesController(city);
  }

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
            ),
            width: device.width,
            height: 72,
            child: Material(
              borderRadius: borderRadius,
              color: Colors.transparent,
              child: InkWell(
                borderRadius: borderRadius,
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
                child: AspectRatio(
                  aspectRatio: 1.1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(city.city,
                                style: Theme.of(context).textTheme.bodyText2),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(city.country,
                                  style: Theme.of(context).textTheme.headline6),
                            )
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () async {
                                Future<void> _showModal = showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return buildBottomSheet(
                                      context: context,
                                      city: city,
                                      delete: delete,
                                      setAsDefault: setAsDefault,
                                      setMainState: setMainState,
                                    );
                                  },
                                );
                                _showModal.then((value) {
                                  setMainState();
                                });
                              },
                              child: Icon(Icons.more_horiz_outlined, size: 35),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, bottom: 16, top: 16),
            child: SizedBox(width: device.width, child: Divider()),
          ),
        ],
      ),
    );
  }
}
