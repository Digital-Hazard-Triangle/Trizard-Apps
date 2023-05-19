import 'package:flutter/material.dart';
import 'package:trizard/history_page/history_view.dart';
import 'package:trizard/theme.dart';

class MapView extends StatefulWidget {
  MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return MapSample(
      latitude: 5.4,
      longitude: 95.323753,
      kondisi: 'ban pecah',
    );
  }
}
