import'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../Providers/tileProvider.dart';
class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  GoogleMapController? _controller;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 4,
  );

  Set<TileOverlay> _tileOverlays = {};
  DateTime _forecastDate = DateTime.now();

  _initTiles(DateTime dateTime) async {
    final String overlayId = dateTime.millisecondsSinceEpoch.toString();
    final tileOverlay = TileOverlay(
        tileOverlayId: TileOverlayId(overlayId),
      tileProvider: ForecastTileProvider(
          mapType: "CL", //https://openweathermap.org/api/weather-map-2#layers
        opacity: 0.8,
        dateTime: dateTime,
      )
    );
    setState(() {
      _tileOverlays = {tileOverlay};
    });

  }

  _changeDate(duration){
    setState(() {
      _forecastDate = _forecastDate.add(duration);
      _initTiles(_forecastDate);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _initialPosition,
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                _controller = controller;
              });
              _initTiles(_forecastDate);
            },
            tileOverlays: _tileOverlays,
          ),
          Positioned(
            bottom: 30,
            child: SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    left: 30,
                    child: ElevatedButton(style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                    ),
                      onPressed: _controller == null ? null : ()
                      {
                        _changeDate(const Duration(hours: -3));
                      },
                      child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                Center(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Data da Previsão:\n${DateFormat('dd/MM/yyyy ha').format(_forecastDate)}",
                      textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  right: 30,
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                    onPressed: _controller == null ? null : ()
                    {
                      _changeDate(const Duration(hours: 3));
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


