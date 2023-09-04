// To parse this JSON data, do
//
//     final cekKelayakanSemproModel = cekKelayakanSemproModelFromJson(jsonString);

import 'dart:convert';

CekKelayakanSemproModel cekKelayakanSemproModelFromJson(String str) => CekKelayakanSemproModel.fromJson(json.decode(str));

String cekKelayakanSemproModelToJson(CekKelayakanSemproModel data) => json.encode(data.toJson());

class CekKelayakanSemproModel {
    int code;
    String errorMessage;
    Data data;

    CekKelayakanSemproModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory CekKelayakanSemproModel.fromJson(Map<String, dynamic> json) => CekKelayakanSemproModel(
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
    Syarat syaratMinimalBimbingan;
    Syarat syaratAccPembimbing;
    int kesimpulan;

    ListClass({
        required this.syaratMinimalBimbingan,
        required this.syaratAccPembimbing,
        required this.kesimpulan,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        syaratMinimalBimbingan: Syarat.fromJson(json["syarat_minimal_bimbingan"]),
        syaratAccPembimbing: Syarat.fromJson(json["syarat_acc_pembimbing"]),
        kesimpulan: json["kesimpulan"],
    );

    Map<String, dynamic> toJson() => {
        "syarat_minimal_bimbingan": syaratMinimalBimbingan.toJson(),
        "syarat_acc_pembimbing": syaratAccPembimbing.toJson(),
        "kesimpulan": kesimpulan,
    };
}

class Syarat {
    int status;
    String message;

    Syarat({
        required this.status,
        required this.message,
    });

    factory Syarat.fromJson(Map<String, dynamic> json) => Syarat(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
