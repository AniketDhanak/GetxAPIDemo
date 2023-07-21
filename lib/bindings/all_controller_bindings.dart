import 'package:get/get.dart';
import 'package:getx_api_demo_mvc/constants/controller_constants.dart';
import 'package:getx_api_demo_mvc/screens/homeScreen/home_controller.dart';
import 'package:getx_api_demo_mvc/screens/splash/splash_controller.dart';

class AllControllerBindings extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut<SplashController>(() => SplashController(),
        tag: ControllerTagConstants.splashControllerTag, fenix: true);
    Get.lazyPut<HomeScreenController>(() => HomeScreenController(),
        tag: ControllerTagConstants.homeController, fenix: true);

  }

}