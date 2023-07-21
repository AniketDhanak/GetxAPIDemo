import 'string_utils.dart';

class FunctionalUtils{
  static Future<String> getSessionKey() async {
    String sessionKey = StringUtils.empty;
    // var idObj = await SessionDAO().getValueForKey(DatabaseKeys.sessionKey);
    // if (idObj != null) {
    //   sessionKey = idObj.value;
    // }
    return sessionKey;
  }
}