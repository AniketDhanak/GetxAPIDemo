import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_demo_mvc/constants/api_constants.dart';
import 'package:getx_api_demo_mvc/constants/routes_constants.dart';
import 'package:getx_api_demo_mvc/constants/string_constants.dart';
import 'package:getx_api_demo_mvc/model/network/users_model.dart';
import 'package:getx_api_demo_mvc/network/base_client.dart';
import 'package:getx_api_demo_mvc/utils/reachability.dart';
import 'package:getx_api_demo_mvc/utils/show_snackbar.dart';

class HomeScreenController extends GetxController {
  var isLoading = false.obs;
  var pageIndex = 1.obs;
  var usersList = <Datum>[].obs;
  var currentIndex = 0.obs;

  late ScrollController scrollController;

  List<String> imageList = [
    "https://picsum.photos/200",
    "https://picsum.photos/200/200/?blur",
    "https://picsum.photos/200/200?grayscale",
    "https://picsum.photos/seed/picsum/200/200",
    "https://picsum.photos/200/200/?blur",
    "https://picsum.photos/200/200?grayscale",
    "https://picsum.photos/seed/picsum/200/200",
    "https://picsum.photos/200",
  ].obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    // getAllUsers(pageIndex.value);
  }

  //onTapMapViewButton
  onTapMapViewButton(){
    Get.toNamed(RouteConstants.mapView);
  }


  //onTap of image
  onTapViewImageItem(BuildContext context, List<String> list, int curIndex) {
    showDialog(
        context: context,
        builder: (context) {
          currentIndex.value = curIndex;
          return Material(
            color: Colors.transparent,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 18),
              child: Container(
                  height: 100,
                  color: Colors.transparent,
                  width: MediaQuery.sizeOf(context).width,
                  child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          0 != currentIndex.value
                              ? GestureDetector(
                                  onTap: () {
                                    if (currentIndex.value != 0) {
                                      currentIndex.value--;
                                    } else {}
                                  },
                                  child: const Icon(Icons.arrow_back_ios))
                              : const SizedBox(
                                  height: 10,
                                  width: 22,
                                ),
                          GestureDetector(
                              onHorizontalDragEnd: (DragEndDetails details) {
                                int sensitivity = 0;
                                // Swiping in right direction.
                                if (details.primaryVelocity! > sensitivity) {
                                  if (currentIndex.value != 0) {
                                    currentIndex.value--;
                                  } else {}
                                }

                                // Swiping in left direction.
                                if (details.primaryVelocity! < sensitivity) {
                                  if (currentIndex.value < imageList.length &&
                                      currentIndex.value !=
                                          imageList.length - 1) {
                                    currentIndex.value++;
                                  } else {}
                                }
                              },
                              child:
                                  Image.network(imageList[currentIndex.value])),
                          currentIndex.value != imageList.length - 1
                              ? GestureDetector(
                                  onTap: () {
                                    if (currentIndex.value < imageList.length) {
                                      currentIndex.value++;
                                    } else {}
                                  },
                                  child: const Icon(Icons.arrow_forward_ios))
                              : const SizedBox(
                                  height: 10,
                                  width: 22,
                                ),
                        ],
                      )) /*ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context,index){
              return showImageItem(list[index], index, context);
            })*/
                  ),
            ),
          );
        });
  }




  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      log("reach the bottom");
      loadMoreData();
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      log("reach the top");
    }
  }

  loadMoreData() {
    pageIndex.value = pageIndex.value + 1;
    getAllUsers(pageIndex.value);
  }

  //get method to getAllUsers
  getAllUsers(int pageIndex) async {
    if (await Reachability.isInternetAvailable() == true) {
      isLoading(true);
      getAllUsersService(pageIndex).then((value) {
        isLoading(false);
        UsersResponseModel responseModel = value;
        if (responseModel.status == 200) {
          usersList.addAll(responseModel.data);
        }
      }).onError((error, stackTrace) {
        isLoading(false);
        ShowSnackBar().errorSnackBar(StringConstants.somethingWentWrong);
      });
    } else {
      ShowSnackBar().errorSnackBar(StringConstants.noInternetConnection);
    }
  }

  //service to call getAllUsers
  Future<UsersResponseModel> getAllUsersService(int pageIndex) {
    return BaseClient.instance
        .get(UrlConstants.getAllData(pageIndex: pageIndex))
        .then((value) => usersResponseModelFromJson(value));
  }
}
