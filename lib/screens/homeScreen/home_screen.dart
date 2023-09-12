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
    HomeScreenController controller =
        Get.find(tag: ControllerTagConstants.homeController);
    return Obx(() => Loader(
        isCallInProgress: controller.isLoading.value,
        child: mainUi(
          context,
          controller,
        )));
  }

  Widget mainUi(BuildContext context, HomeScreenController controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo App"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //API Listview builder
              /* Text(
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
              ),*/

              //onTap show slider demo
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                      itemCount: controller.imageList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return listCard(controller.imageList[index], controller,
                            controller.imageList, index);
                      }),
                ),
              ),
              ElevatedButton(onPressed: () {
                controller.onTapMapViewButton();
              }, child: Text("Go To MapView"))
            ],
          ),
        ),
      ),
    );
  }

  Widget listCard(String imgPath, HomeScreenController controller,
      List<String> imageList, int currentIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          controller.onTapViewImageItem(Get.context!, imageList, currentIndex);
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.black),
              borderRadius: BorderRadius.circular(10)),
          child: Image.network(
            imgPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
