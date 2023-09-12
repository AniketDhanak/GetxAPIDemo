import 'package:get/get.dart';
import 'package:getx_api_demo_mvc/constants/routes_constants.dart';
import 'package:getx_api_demo_mvc/screens/homeScreen/home_screen.dart';
import 'package:getx_api_demo_mvc/screens/mapView/map_view_screen.dart';
import 'package:getx_api_demo_mvc/screens/splash/splash_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: RouteConstants.initialRoute, page: ()=> const SplashScreen()),
    GetPage(name: RouteConstants.homeScreen, page: ()=> const HomeScreen()),
    GetPage(name: RouteConstants.mapView, page: ()=> const MapViewScreen())
  ];
}