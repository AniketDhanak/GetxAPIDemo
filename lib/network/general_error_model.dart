import 'dart:convert';

GeneralErrorModel generalErrorModelFromJson(String str) =>
    GeneralErrorModel.fromJson(json.decode(str));

class GeneralErrorModel {
  GeneralErrorModel({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  factory GeneralErrorModel.fromJson(Map<String, dynamic> json) =>
      GeneralErrorModel(
        status: json["status"],
        message: json["message"],
      );
  factory GeneralErrorModel.fromRawJson(String str) =>
      GeneralErrorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
