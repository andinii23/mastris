// To parse this JSON data, do
//
//     final arsipBeritaAcaraModel = arsipBeritaAcaraModelFromJson(jsonString);

import 'dart:convert';

ArsipBeritaAcaraModel arsipBeritaAcaraModelFromJson(String str) => ArsipBeritaAcaraModel.fromJson(json.decode(str));

String arsipBeritaAcaraModelToJson(ArsipBeritaAcaraModel data) => json.encode(data.toJson());

class ArsipBeritaAcaraModel {
    int code;
    String errorMessage;
    Data data;

    ArsipBeritaAcaraModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory ArsipBeritaAcaraModel.fromJson(Map<String, dynamic> json) => ArsipBeritaAcaraModel(
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
    String namaMahasiswa;
    String noMhs;
    String textJabatan;
    String tanggal;
    String nomorSurat;
    String hashTtd;
    String namaSeminar;
    int idJadwalPresentasi;
    String textBelumDiisi;

    ListElement({
        required this.namaMahasiswa,
        required this.noMhs,
        required this.textJabatan,
        required this.tanggal,
        required this.nomorSurat,
        required this.hashTtd,
        required this.namaSeminar,
        required this.idJadwalPresentasi,
        required this.textBelumDiisi,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        namaMahasiswa: json["nama_mahasiswa"],
        noMhs: json["no_mhs"],
        textJabatan: json["text_jabatan"],
        tanggal: json["tanggal"],
        nomorSurat: json["nomor_surat"],
        hashTtd: json["hash_ttd"],
        namaSeminar: json["nama_seminar"],
        idJadwalPresentasi: json["id_jadwal_presentasi"],
        textBelumDiisi: json["text_belum_diisi"],
    );

    Map<String, dynamic> toJson() => {
        "nama_mahasiswa": namaMahasiswa,
        "no_mhs": noMhs,
        "text_jabatan": textJabatan,
        "tanggal": tanggal,
        "nomor_surat": nomorSurat,
        "hash_ttd": hashTtd,
        "nama_seminar": namaSeminar,
        "id_jadwal_presentasi": idJadwalPresentasi,
        "text_belum_diisi": textBelumDiisi,
    };
}



