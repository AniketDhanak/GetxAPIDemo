import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_demo_mvc/constants/app_colors.dart';
import 'package:getx_api_demo_mvc/constants/controller_constants.dart';
import 'package:getx_api_demo_mvc/constants/style_constants.dart';
import 'package:getx_api_demo_mvc/screens/homeScreen/home_controller.dart';
import 'package:getx_api_demo_mvc/screens/loader/loader.dart';
import 'package:getx_api_demo_mvc/screens/usersCard/users_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller = Get.find(tag: ControllerTagConstants.homeController);
    return Obx(() => Loader(
        isCallInProgress: controller.isLoading.value,
        child: mainUi(
          context,
          controller,
        )));
  }

  Widget mainUi(BuildContext context, HomeScreenController controller) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Flutter GetX Demo",
                style: StyleConstants.h128PxStyleBold(color: AppColors.primaryColor)
              ),
             controller.usersList.isNotEmpty ?
             ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.usersList.length,
                  itemBuilder: (context,index){
                return UsersCard(datum: controller.usersList[index], index: index,);
              }):  Visibility(
               visible:!controller.isLoading.value,
                child: Text(
                   "Users not available",
                   style: StyleConstants.h128PxStyleBold(color: AppColors.primaryColor)
             ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
