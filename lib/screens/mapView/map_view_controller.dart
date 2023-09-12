import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapViewController extends GetxController{

  final Completer<GoogleMapController> mapCompleterController =
  Completer<GoogleMapController>();
  var currentLat = 0.0.obs;
  var currentLng = 0.0.obs;
  var currentLocation = "".obs;
  var isLoading = false.obs;
  GoogleMapController? googleMapController;
  Permission? _permission;
  PermissionStatus _permissionStatus = PermissionStatus.denied;


  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(18.5204, 73.8567),
    zoom: 14.4746,
  );

  List<Marker> markers = <Marker>[];


  @override
  void onInit() {
    super.onInit();
    _permission = Permission.location;
    // googleMapController = GoogleMapController.init(id, initialCameraPosition, googleMapState);
    // getLocation();
  }



  Future<void> moveCamera(double lat,double long) async {
    final GoogleMapController controller = await mapCompleterController.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat,long),
      zoom: 14,
    )));
  }

  getLocation() {
    log("getLocation");
    if (Platform.isIOS) {
      log("Ios");
      _determinePosition().then((value) {
        currentLat.value = value.latitude;
        currentLng.value = value.longitude;
        moveCamera(currentLat.value, currentLng.value);
        log(currentLat.value.toString());
        log(currentLng.value.toString());
      });
    } else {
      _listenForPermissionStatus();
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    log("determinePermission $serviceEnabled");

    if (serviceEnabled) {
      permission = await Geolocator.requestPermission();
      log("serviceEnabled $serviceEnabled");
      isLoading(true);
      return await Geolocator.getCurrentPosition().then((value) {
        log("getCurrentPosition: $value");
        currentLat.value = value.latitude;
        currentLng.value = value.longitude;
        googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(LatLng(currentLat.value, currentLng.value), 15));


        return value;
      });
    }

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      log("!serviceEnabled $serviceEnabled");
      openAppSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }



  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();

    _permissionStatus = status;
    if (status.isGranted) {
      _determinePosition();
    }
    if (Platform.isAndroid) {
      if (status.isDenied) {
        openAppSettings();
      }
    }
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void _listenForPermissionStatus() async {
    log("Listen");
    final status = await _permission!.status;
    _permissionStatus = status;
    if (_permissionStatus.isGranted) {
      log("grandted");
      _determinePosition();
    }
    if (_permissionStatus.isDenied) {
      requestPermission(_permission!);
    }
    if (_permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    }
    log("Listen: $_permissionStatus");
  }

  changePosition(lat, long) {
    googleMapController!
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), 15));
    markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(lat, long),
        infoWindow: const InfoWindow(title: 'Check In')));
  }

}