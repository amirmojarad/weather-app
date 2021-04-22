import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

buildCard({
  Config config,
  Color backgroundColor = Colors.transparent,
  DecorationImage backgroundImage,
}) {
  return Container(
    height: 50,
    width: double.infinity,
    child: Card(
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      child: WaveWidget(
        config: config,
        backgroundColor: Colors.transparent,
        size: Size(double.infinity, double.infinity),
        waveAmplitude: 0,
      ),
    ),
  );
}