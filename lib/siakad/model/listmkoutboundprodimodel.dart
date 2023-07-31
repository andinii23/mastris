// To parse this JSON data, do
//
//     final listMkOutboundProdiModel = listMkOutboundProdiModelFromJson(jsonString);

import 'dart:convert';

ListMkOutboundProdiModel listMkOutboundProdiModelFromJson(String str) => ListMkOutboundProdiModel.fromJson(json.decode(str));

String listMkOutboundProdiModelToJson(ListMkOutboundProdiModel data) => json.encode(data.toJson());

class ListMkOutboundProdiModel {
    int code;
    String errorMessage;
    Data data;

    ListMkOutboundProdiModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory ListMkOutboundProdiModel.fromJson(Map<String, dynamic> json) => ListMkOutboundProdiModel(
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
    String perPage;
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
    int idMatakuliah;
    String kodeMatakuliah;
    String namaMatakuliah;
    dynamic sksTotal;
    String idProdi;
    Prodi prodi;

    ListElement({
        required this.idMatakuliah,
        required this.kodeMatakuliah,
        required this.namaMatakuliah,
        this.sksTotal,
        required this.idProdi,
        required this.prodi,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idMatakuliah: json["id_matakuliah"],
        kodeMatakuliah: json["kode_matakuliah"],
        namaMatakuliah: json["nama_matakuliah"],
        sksTotal: json["sks_total"],
        idProdi: json["id_prodi"],
        prodi: Prodi.fromJson(json["prodi"]),
    );

    Map<String, dynamic> toJson() => {
        "id_matakuliah": idMatakuliah,
        "kode_matakuliah": kodeMatakuliah,
        "nama_matakuliah": namaMatakuliah,
        "sks_total": sksTotal,
        "id_prodi": idProdi,
        "prodi": prodi.toJson(),
    };
}

class Prodi {
    String idProdi;
    String namaProdi;
    String jenjang;

    Prodi({
        required this.idProdi,
        required this.namaProdi,
        required this.jenjang,
    });

    factory Prodi.fromJson(Map<String, dynamic> json) => Prodi(
        idProdi: json["id_prodi"],
        namaProdi: json["nama_prodi"],
        jenjang: json["jenjang"],
    );

    Map<String, dynamic> toJson() => {
        "id_prodi": idProdi,
        "nama_prodi": namaProdi,
        "jenjang": jenjang,
    };
}




