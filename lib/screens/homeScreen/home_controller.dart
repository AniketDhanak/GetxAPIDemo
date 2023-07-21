import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_demo_mvc/constants/api_constants.dart';
import 'package:getx_api_demo_mvc/constants/string_constants.dart';
import 'package:getx_api_demo_mvc/model/network/users_model.dart';
import 'package:getx_api_demo_mvc/network/base_client.dart';
import 'package:getx_api_demo_mvc/utils/reachability.dart';
import 'package:getx_api_demo_mvc/utils/show_snackbar.dart';

class HomeScreenController extends GetxController{


  var isLoading = false.obs;
  var pageIndex = 1.obs;
  var usersList = <Datum>[].obs;

  late ScrollController scrollController;


  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    getAllUsers(pageIndex.value);
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

  loadMoreData(){
    pageIndex.value = pageIndex.value + 1;
    getAllUsers(pageIndex.value);
  }

  //get method to getAllUsers
  getAllUsers(int pageIndex)async{
    if (await Reachability.isInternetAvailable() == true) {
      isLoading(true);
      getAllUsersService(pageIndex).then((value){
        isLoading(false);
        UsersResponseModel responseModel = value;
        if(responseModel.status == 200){
          usersList.addAll(responseModel.data);
        }

      }).onError((error, stackTrace) {
        isLoading(false);
        ShowSnackBar().errorSnackBar(StringConstants.somethingWentWrong);
      });
    }else{
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