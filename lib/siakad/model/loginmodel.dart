// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.code,
    required this.errorMessage,
    required this.data,
  });

  int code;
  String errorMessage;
  Data data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        code: json["code"],
        errorMessage: json["error_message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "error_message": errorMessage,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.total,
    required this.perPage,
    required this.page,
    required this.list,
  });

  int total;
  int perPage;
  int page;
  ListClass list;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        perPage: json["per_page"],
        page: json["page"],
        list: ListClass.fromJson(json["list"]),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "per_page": perPage,
        "page": page,
        "list": list.toJson(),
      };
}

class ListClass {
  ListClass({
    required this.token,
    required this.user,
  });

  String token;
  User user;

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.username,
    required this.name,
    required this.usertype,
    required this.status,
  });

  String username;
  String name;
  String usertype;
  String? status;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        name: json["name"],
        usertype: json["usertype"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "usertype": usertype,
        "status": status,
      };
}
