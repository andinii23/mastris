// To parse this JSON data, do
//
//     final mhsBimbinganModel = mhsBimbinganModelFromJson(jsonString);

import 'dart:convert';

MhsBimbinganModel mhsBimbinganModelFromJson(String str) => MhsBimbinganModel.fromJson(json.decode(str));

String mhsBimbinganModelToJson(MhsBimbinganModel data) => json.encode(data.toJson());

class MhsBimbinganModel {
    int code;
    String errorMessage;
    Data data;

    MhsBimbinganModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory MhsBimbinganModel.fromJson(Map<String, dynamic> json) => MhsBimbinganModel(
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
    int idPembimbingAkademik;
    int idMhsPt;
    int idDosen;
    String noMahasiswa;
    String idStatusMahasiswa;
    String namaMahasiswa;
    String? statusKrs;
    String? statusKrsText;

    ListElement({
        required this.idPembimbingAkademik,
        required this.idMhsPt,
        required this.idDosen,
        required this.noMahasiswa,
        required this.idStatusMahasiswa,
        required this.namaMahasiswa,
        this.statusKrs,
        this.statusKrsText,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idPembimbingAkademik: json["id_pembimbing_akademik"],
        idMhsPt: json["id_mhs_pt"],
        idDosen: json["id_dosen"],
        noMahasiswa: json["no_mahasiswa"],
        idStatusMahasiswa: json["id_status_mahasiswa"],
        namaMahasiswa: json["nama_mahasiswa"],
        statusKrs: json["status_krs"],
        statusKrsText: json["status_krs_text"],
    );

    Map<String, dynamic> toJson() => {
        "id_pembimbing_akademik": idPembimbingAkademik,
        "id_mhs_pt": idMhsPt,
        "id_dosen": idDosen,
        "no_mahasiswa": noMahasiswa,
        "id_status_mahasiswa": idStatusMahasiswa,
        "nama_mahasiswa": namaMahasiswa,
        "status_krs": statusKrs,
        "status_krs_text": statusKrsText,
    };
}


