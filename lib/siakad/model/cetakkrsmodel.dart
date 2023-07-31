// To parse this JSON data, do
//
//     final cetakKrsModel = cetakKrsModelFromJson(jsonString);

import 'dart:convert';

CetakKrsModel cetakKrsModelFromJson(String str) => CetakKrsModel.fromJson(json.decode(str));

String cetakKrsModelToJson(CetakKrsModel data) => json.encode(data.toJson());

class CetakKrsModel {
    int code;
    String errorMessage;
    Data data;

    CetakKrsModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory CetakKrsModel.fromJson(Map<String, dynamic> json) => CetakKrsModel(
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
    String url;
    String idMhsPt;

    ListClass({
        required this.url,
        required this.idMhsPt,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        url: json["url"],
        idMhsPt: json["id_mhs_pt"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "id_mhs_pt": idMhsPt,
    };
}
