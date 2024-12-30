import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class CurrentLocationButton extends StatelessWidget {
  // const CurrentLocationButton({Key? key}) : super(key: key);
  late StreamSubscription<Position> positionStream;

  Future<void> _getCurrentLocationAndOpenMap() async {
    try {
      // Check location permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied. Enable them in settings.');
      }

      if (permission == LocationPermission.whileInUse) {
        // Get the current position
        // Position position = await Geolocator.getCurrentPosition(
        //     desiredAccuracy: LocationAccuracy.high);

        // final latitude = position.latitude;
        // final longitude = position.longitude;
        positionStream =
            Geolocator.getPositionStream().listen((Position? position) {
          print(position!.latitude);
          print(position!.longitude);
        });
      }

      // Construct Google Maps URL
      //   final googleMapsUrl =
      //       'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      //   // Launch URL
      //   if (await canLaunch(googleMapsUrl)) {
      //     await launch(googleMapsUrl);
      //   } else {
      //     throw Exception('Could not open Google Maps.');
      //   }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _getCurrentLocationAndOpenMap,
        child: const Text('Show Current Location'),
      ),
    );
  }
}
