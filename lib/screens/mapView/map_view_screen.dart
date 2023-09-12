import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_demo_mvc/constants/controller_constants.dart';
import 'package:getx_api_demo_mvc/screens/mapView/map_view_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MapViewController controller = Get.find(tag: ControllerTagConstants.mapViewControllerTag);
    return Scaffold(
      appBar: AppBar(
        title: Text("MapView"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: controller.kGooglePlex,
        onMapCreated: (GoogleMapController mapController) {
          controller.mapCompleterController.complete(mapController);
          controller.getLocation();
        },
      ),
    );
  }
}
