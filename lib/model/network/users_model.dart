// To parse this JSON data, do
//
//     final usersResponseModel = usersResponseModelFromJson(jsonString);

import 'dart:convert';

UsersResponseModel usersResponseModelFromJson(String str) => UsersResponseModel.fromJson(json.decode(str));

String usersResponseModelToJson(UsersResponseModel data) => json.encode(data.toJson());

class UsersResponseModel {
  int status;
  String message;
  List<Datum> data;

  UsersResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) => UsersResponseModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int userId;
  String userName;
  String email;

  Datum({
    required this.userId,
    required this.userName,
    required this.email,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userId: json["UserId"],
    userName: json["UserName"],
    email: json["Email"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "UserName": userName,
    "Email": email,
  };
}

