import 'dart:convert';
import 'package:getx_api_demo_mvc/constants/api_constants.dart';
import 'package:getx_api_demo_mvc/constants/string_constants.dart';
import 'package:getx_api_demo_mvc/network/app_exception.dart';
import 'package:getx_api_demo_mvc/network/general_error_model.dart';
import 'package:getx_api_demo_mvc/utils/funtction_utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BaseClient {
  static final BaseClient _instance = BaseClient._();
  BaseClient._();
  static BaseClient get instance => _instance;
  static const int timeOutDuration = 90;

  Map<String, String> header = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

  // Get Method
  Future<dynamic> get(String api) async {
    var uri = Uri.parse(UrlConstants.baseUrl + api);
    debugPrint(uri.toString());
    await addSessionKeyToHeader();
    try {
      var response = await http
          .get(uri, headers: header)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on GeneralApiResponseErrorException catch (error) {
      throw GeneralApiResponseErrorException(error.errorModel);
    } on Exception {
      throw GeneralApiResponseErrorException(getDefaultErrorResponse());
    }
  }

  // Get Method for Google Map
  Future<dynamic> getGoogleMap(String api) async {
    var uri = Uri.parse(api);
    debugPrint(uri.toString());
    await addSessionKeyToHeader();
    try {
      var response = await http
          .get(uri, headers: header)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on GeneralApiResponseErrorException catch (error) {
      throw GeneralApiResponseErrorException(error.errorModel);
    } on Exception {
      throw GeneralApiResponseErrorException(getDefaultErrorResponse());
    }
  }

  //POST
  Future<dynamic> post(String api, dynamic payloadObj) async {
    var uri = Uri.parse(UrlConstants.baseUrl + api);
    var payload = json.encode(payloadObj);
    debugPrint("payLoad-----$payload");
    debugPrint("header $header");
    debugPrint(uri.toString());
    await addSessionKeyToHeader();
    try {
      var response = await http
          .post(uri, headers: header, body: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on GeneralApiResponseErrorException catch (error) {
      throw GeneralApiResponseErrorException(error.errorModel);
    } on Exception {
      throw GeneralApiResponseErrorException(getDefaultErrorResponse());
    }
  }

  //put
  Future<dynamic> put(String api, dynamic payloadObj) async {
    var uri = Uri.parse(UrlConstants.baseUrl + api);
    var payload = json.encode(payloadObj);
    debugPrint("payLoad-----$payload");
    debugPrint(uri.toString());
    await addSessionKeyToHeader();
    try {
      var response = await http
          .put(uri, headers: header, body: payload)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on GeneralApiResponseErrorException catch (error) {
      throw GeneralApiResponseErrorException(error.errorModel);
    } on Exception {
      throw GeneralApiResponseErrorException(getDefaultErrorResponse());
    }
  }

  //DELETE
  Future<dynamic> delete(String api) async {
    var uri = Uri.parse(UrlConstants.baseUrl + api);
    debugPrint(uri.toString());
    await addSessionKeyToHeader();
    try {
      var response = await http
          .delete(uri, headers: header)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } on GeneralApiResponseErrorException catch (error) {
      throw GeneralApiResponseErrorException(error.errorModel);
    } on Exception {
      throw GeneralApiResponseErrorException(getDefaultErrorResponse());
    }
  }

  dynamic _processResponse(http.Response response) {
    debugPrint("response ${response.body.toString()}");
    if (response.isOkResponse()) {
      debugPrint("Ok");
      return utf8.decode(response.bodyBytes);
    } else if (response.isUnauthorizedUser()) {
      //FunctionalUtils.clearSessionData();
      //   getErrorModel(response);
    } else {
      debugPrint("Not Ok");
      getErrorModel(response);
    }
  }

  getErrorModel(http.Response response) {
    var errorList = generalErrorModelFromJson(response.body.toString());
    debugPrint("ErrorList--->${errorList.message.toString()}");
    if (errorList.message != null) {
      String value = errorList.toRawJson().toString();
      throw GeneralApiResponseErrorException(value);
    } else {
      throw GeneralApiResponseErrorException(getDefaultErrorResponse());
    }
  }

  String getDefaultErrorResponse() {
    debugPrint("Default error send");
    String defaultValue =
        GeneralErrorModel(message: StringConstants.somethingWentWrong)
            .toRawJson();
    return defaultValue.toString();
  }

  addSessionKeyToHeader() async {
    String sessionKey = await FunctionalUtils.getSessionKey();
    debugPrint("Bearer $sessionKey");
    if (sessionKey.isNotEmpty) {
      header["Authorization"] = "Bearer $sessionKey";
    } else {
      header.remove("Authorization");
    }
  }
}

extension on http.Response {
  bool isOkResponse() {
    return statusCode >= 200 && statusCode <= 299;
  }

  bool isUnauthorizedUser() {
    return statusCode == 401;
  }
}
