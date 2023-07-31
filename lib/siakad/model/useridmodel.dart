// To parse this JSON data, do
//
//     final userIdModel = userIdModelFromJson(jsonString);

import 'dart:convert';

UserIdModel userIdModelFromJson(String str) => UserIdModel.fromJson(json.decode(str));

String userIdModelToJson(UserIdModel data) => json.encode(data.toJson());

class UserIdModel {
    int code;
    String errorMessage;
    Data data;

    UserIdModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory UserIdModel.fromJson(Map<String, dynamic> json) => UserIdModel(
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
    int total;
    int perPage;
    int page;
    ListClass list;

    Data({
        required this.total,
        required this.perPage,
        required this.page,
        required this.list,
    });

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
    int idMhsPt;
    int idProdi;

    ListClass({
        required this.idMhsPt,
        required this.idProdi,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        idMhsPt: json["id_mhs_pt"],
        idProdi: json["id_prodi"],
    );

    Map<String, dynamic> toJson() => {
        "id_mhs_pt": idMhsPt,
        "id_prodi": idProdi,
    };
}
