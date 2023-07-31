// To parse this JSON data, do
//
//     final versiModel = versiModelFromJson(jsonString);

import 'dart:convert';

VersiModel versiModelFromJson(String str) => VersiModel.fromJson(json.decode(str));

String versiModelToJson(VersiModel data) => json.encode(data.toJson());

class VersiModel {
    int code;
    String errorMessage;
    Data data;

    VersiModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory VersiModel.fromJson(Map<String, dynamic> json) => VersiModel(
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
    String version;
    int needUpdate;
    String description;
    dynamic createdAt;
    DateTime updatedAt;
    String appUrl;

    ListClass({
        required this.version,
        required this.needUpdate,
        required this.description,
        this.createdAt,
        required this.updatedAt,
        required this.appUrl,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        version: json["version"],
        needUpdate: json["need_update"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        appUrl: json["app_url"],
    );

    Map<String, dynamic> toJson() => {
        "version": version,
        "need_update": needUpdate,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "app_url": appUrl,
    };
}
