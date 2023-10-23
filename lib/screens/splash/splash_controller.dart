import 'dart:developer';

import 'package:get/get.dart';
import 'package:getx_api_demo_mvc/constants/routes_constants.dart';

class SplashController extends GetxController {

  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    startTimer();
  }


  startTimer(){
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(RouteConstants.homeScreen);
    });
  }


}
