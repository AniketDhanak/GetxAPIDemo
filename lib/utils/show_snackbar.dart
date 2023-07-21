
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_demo_mvc/constants/app_colors.dart';
import 'package:getx_api_demo_mvc/constants/string_constants.dart';
import 'package:getx_api_demo_mvc/constants/style_constants.dart';
import 'package:getx_api_demo_mvc/network/general_error_model.dart';

class ShowSnackBar {
  successSnackBar(String message) {
    Get.snackbar(
      StringConstants.success,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.darkGreen,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: AppColors.white,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  errorSnackBar(String message) {
    Get.snackbar(
      StringConstants.failure,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: AppColors.white,
      duration: const Duration(seconds: 2),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  validationSnackBar(String message) {
    Get.snackbar(
      StringConstants.validationFailure,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      borderRadius: 20,
      messageText: Text(message,style: StyleConstants.h612PxStyleRegular(color: AppColors.white),),
      colorText: AppColors.white,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      forwardAnimationCurve: Curves.decelerate,
    );
  }

  showError(generalErrorModel) {
    GeneralErrorModel errorModel = generalErrorModel;
    debugPrint(errorModel.message);
    errorSnackBar(errorModel.message.toString());
  }

}
