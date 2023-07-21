import 'package:flutter/material.dart';
import 'package:getx_api_demo_mvc/constants/font_constants.dart';

class StyleConstants{


  static h128PxStyleRegular({required Color color}){
    return TextStyle(
      fontFamily: FontConstants.poppinsRegular,
      fontWeight: FontWeight.normal,
      fontSize: 28,
      color: color
    );
  }

  static h128PxStyleMedium({required Color color}){
    return TextStyle(
        fontFamily: FontConstants.poppinsRegular,
        fontWeight: FontWeight.w500,
        fontSize: 28,
        color: color
    );
  }

  static h128PxStyleBold({required Color color}){
    return TextStyle(
        fontFamily: FontConstants.poppinsRegular,
        fontWeight: FontWeight.bold,
        fontSize: 28,
        color: color
    );
  }

  static h612PxStyleBold({required Color color}){
    return TextStyle(
        fontFamily: FontConstants.poppinsRegular,
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: color
    );
  }

  static h612PxStyleMedium({required Color color}){
    return TextStyle(
        fontFamily: FontConstants.poppinsRegular,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: color
    );
  }

  static h612PxStyleRegular({required Color color}){
    return TextStyle(
        fontFamily: FontConstants.poppinsRegular,
        fontWeight: FontWeight.normal,
        fontSize: 12,
        color: color
    );
  }
  static h614PxStyleBold({required Color color}){
    return TextStyle(
        fontFamily: FontConstants.poppinsRegular,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: color
    );
  }

  static h614PxStyleMedium({required Color color}){
    return TextStyle(
        fontFamily: FontConstants.poppinsRegular,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: color
    );
  }

  static h614PxStyleRegular({required Color color}){
    return TextStyle(
        fontFamily: FontConstants.poppinsRegular,
        fontWeight: FontWeight.normal,
        fontSize: 14,
        color: color
    );
  }
}