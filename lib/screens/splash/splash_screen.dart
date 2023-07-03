import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_demo_mvc/constants/app_colors.dart';
import 'package:getx_api_demo_mvc/constants/controller_constants.dart';
import 'package:getx_api_demo_mvc/screens/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashController controller = Get.find(tag: ControllerTagConstants.splashControllerTag);
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.white,
      child: controller.isLoading.value ?
      Center(child: CircularProgressIndicator()):
      ListView.builder(
          itemCount: controller.characters.length,
          itemBuilder: (context, index){
return Card(
  child: ListTile(
    leading: Image(
      image: NetworkImage(
       controller.characters[index]['image'],
      ),
    ),
    title: Text(
      controller.characters[index]['name'],
    ),
  ),
);
      }),
    );
  }
}
