



import 'package:getx_api_demo_mvc/constants/string_constants.dart';
import 'package:getx_api_demo_mvc/network/app_exception.dart';
import 'package:getx_api_demo_mvc/network/general_error_model.dart';

class FetchException implements Exception {
  final dynamic _errorModel;

  FetchException([this._errorModel]);

  GeneralErrorModel fetchErrorModel() {
    if (_errorModel == null) {
      return GeneralErrorModel(message: StringConstants.somethingWentWrong);
    }

    String model = StringConstants.somethingWentWrong;

    if (_errorModel is GeneralApiResponseErrorException) {
      model = (_errorModel as GeneralApiResponseErrorException)
          .errorModel
          .toString()
          .replaceFirst("Exception: ", "", 0);
      return GeneralErrorModel.fromRawJson(model);
    }

    return GeneralErrorModel(message: model);
  }
}
