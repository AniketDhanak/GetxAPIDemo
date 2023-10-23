import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_demo_mvc/bindings/all_controller_bindings.dart';
import 'package:getx_api_demo_mvc/constants/app_colors.dart';
import 'package:getx_api_demo_mvc/constants/font_constants.dart';
import 'package:getx_api_demo_mvc/constants/routes_constants.dart';
import 'package:getx_api_demo_mvc/constants/string_constants.dart';
import 'package:getx_api_demo_mvc/extensions/color_extensions.dart';
import 'package:getx_api_demo_mvc/routes/app_routes.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: StringConstants.title,
      theme: ThemeData(
        primarySwatch: AppColors.primaryColor.toMaterialColor(),
        fontFamily: FontConstants.poppins
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteConstants.initialRoute,
      initialBinding: AllControllerBindings(),
      getPages: AppRoutes.routes,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}
