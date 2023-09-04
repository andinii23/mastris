// To parse this JSON data, do
//
//     final timelineModel = timelineModelFromJson(jsonString);

import 'dart:convert';

TimelineModel timelineModelFromJson(String str) => TimelineModel.fromJson(json.decode(str));

String timelineModelToJson(TimelineModel data) => json.encode(data.toJson());

class TimelineModel {
    int code;
    String errorMessage;
    Data data;

    TimelineModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory TimelineModel.fromJson(Map<String, dynamic> json) => TimelineModel(
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
    List<ListElement> list;

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
        list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "per_page": perPage,
        "page": page,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
    };
}

class ListElement {
    int idMhsPt;
    String nim;
    String nama;
    DateTime tanggalPengajuan;
    int statusAjuan;

    ListElement({
        required this.idMhsPt,
        required this.nim,
        required this.nama,
        required this.tanggalPengajuan,
        required this.statusAjuan,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idMhsPt: json["id_mhs_pt"],
        nim: json["nim"],
        nama: json["nama"],
        tanggalPengajuan: DateTime.parse(json["tanggal_pengajuan"]),
        statusAjuan: json["status_ajuan"],
    );

    Map<String, dynamic> toJson() => {
        "id_mhs_pt": idMhsPt,
        "nim": nim,
        "nama": nama,
        "tanggal_pengajuan": tanggalPengajuan.toIso8601String(),
        "status_ajuan": statusAjuan,
    };
}
