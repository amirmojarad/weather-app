import 'package:flutter/material.dart';
import 'package:weather/models/utils/device.dart';
import 'package:weather/view_models/database_handler/city.dart';

import 'action_bottom_sheet.dart';

class CitiesCard extends StatefulWidget {
  City city;
  Function setAsDefault;
  Function delete;

  CitiesCard(this.city, this.setAsDefault, this.delete);

  @override
  _CitiesCardState createState() => _CitiesCardState(this.city);
}

class _CitiesCardState extends State<CitiesCard> {
  City city;

  _CitiesCardState(
    this.city,
  );

  BorderRadius borderRadius = BorderRadius.all(Radius.circular(12));

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                splashColor: Color(0xffDAF7FF),
                borderRadius: borderRadius,
                onTap: () {},
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
                                style: Theme.of(context).textTheme.bodyText1),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(city.country,
                                  style: Theme.of(context).textTheme.headline3),
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
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return buildBottomSheet(
                                        context: context,
                                        city: city,
                                        delete: widget.delete,
                                        setAsDefault: widget.setAsDefault);
                                  },
                                );
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
