import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:weather/view_models/database_handler/city.dart';

class DatabaseHandler {
  Database _database;
  String _path, _dbDir;
  List<City> cities;

  void _makeItWritable() async {
    ByteData data = await rootBundle.load("assets/database/cities.sqlite");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(_path).writeAsBytes(bytes);
  }

  void generatePath() async {
    _dbDir = await getDatabasesPath();
    _path = join(_dbDir, "cities.sqlite");
    await deleteDatabase(_path);
    await _makeItWritable();
    _database = await openDatabase(_path, version: 1);
  }

  void generateCities() async {
    var col = await _database
        .query('cities', columns: ['city', 'lon', 'lat', 'country']);
    cities = List.generate(col.length, (index) {
      if (index + 1 <= col.length - 1)
        return City.fromDB(
          city: col[index + 1]['city'],
          lon: col[index + 1]['lon'],
          lat: col[index + 1]['lat'],
          country: col[index + 1]['country'],
        );
      else
        return null;
    });
    cities.removeLast();
  }
}
