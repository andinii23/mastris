// To parse this JSON data, do
//
//     final agendaBimbinganModel = agendaBimbinganModelFromJson(jsonString);

import 'dart:convert';

AgendaBimbinganModel agendaBimbinganModelFromJson(String str) => AgendaBimbinganModel.fromJson(json.decode(str));

String agendaBimbinganModelToJson(AgendaBimbinganModel data) => json.encode(data.toJson());

class AgendaBimbinganModel {
    int code;
    String errorMessage;
    Data data;

    AgendaBimbinganModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory AgendaBimbinganModel.fromJson(Map<String, dynamic> json) => AgendaBimbinganModel(
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
    String tanggal;
    int idDosen;
    String namaDosen;
    dynamic gelarDepan;
    String gelarBelakang;
    String jenisBimbingan;
    String permasalahan;
    String solusi;

    ListElement({
        required this.tanggal,
        required this.idDosen,
        required this.namaDosen,
        this.gelarDepan,
        required this.gelarBelakang,
        required this.jenisBimbingan,
        required this.permasalahan,
        required this.solusi,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        tanggal: json["tanggal"],
        idDosen: json["id_dosen"],
        namaDosen: json["nama_dosen"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
        jenisBimbingan: json["jenis_bimbingan"],
        permasalahan: json["permasalahan"],
        solusi: json["solusi"],
    );

    Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "id_dosen": idDosen,
        "nama_dosen": namaDosen,
        "gelar_depan": gelarDepan,
        "gelar_belakang": gelarBelakang,
        "jenis_bimbingan": jenisBimbingan,
        "permasalahan": permasalahan,
        "solusi": solusi,
    };
}




