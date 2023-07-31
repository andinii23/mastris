// To parse this JSON data, do
//
//     final detailPresensiModel = detailPresensiModelFromJson(jsonString);

import 'dart:convert';

DetailPresensiModel detailPresensiModelFromJson(String str) => DetailPresensiModel.fromJson(json.decode(str));

String detailPresensiModelToJson(DetailPresensiModel data) => json.encode(data.toJson());

class DetailPresensiModel {
    int code;
    String errorMessage;
    Data data;

    DetailPresensiModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory DetailPresensiModel.fromJson(Map<String, dynamic> json) => DetailPresensiModel(
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
    int idMonitoringPerkuliahan;
    int idKelas;
    DateTime tanggal;
    String jamMulai;
    String jamSelesai;
    String materi;
    List<Mahasiswa> mahasiswa;
    List<Dosen> dosen;

    ListElement({
        required this.idMonitoringPerkuliahan,
        required this.idKelas,
        required this.tanggal,
        required this.jamMulai,
        required this.jamSelesai,
        required this.materi,
        required this.mahasiswa,
        required this.dosen,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idMonitoringPerkuliahan: json["id_monitoring_perkuliahan"],
        idKelas: json["id_kelas"],
        tanggal: DateTime.parse(json["tanggal"]),
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        materi: json["materi"],
        mahasiswa: List<Mahasiswa>.from(json["mahasiswa"].map((x) => Mahasiswa.fromJson(x))),
        dosen: List<Dosen>.from(json["dosen"].map((x) => Dosen.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_monitoring_perkuliahan": idMonitoringPerkuliahan,
        "id_kelas": idKelas,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "materi": materi,
        "mahasiswa": List<dynamic>.from(mahasiswa.map((x) => x.toJson())),
        "dosen": List<dynamic>.from(dosen.map((x) => x.toJson())),
    };
}

class Dosen {
    int idDosen;
    String namaPegawai;
    dynamic gelarDepan;
    String gelarBelakang;

    Dosen({
        required this.idDosen,
        required this.namaPegawai,
        this.gelarDepan,
        required this.gelarBelakang,
    });

    factory Dosen.fromJson(Map<String, dynamic> json) => Dosen(
        idDosen: json["id_dosen"],
        namaPegawai: json["nama_pegawai"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
    );

    Map<String, dynamic> toJson() => {
        "id_dosen": idDosen,
        "nama_pegawai": namaPegawai,
        "gelar_depan": gelarDepan,
        "gelar_belakang": gelarBelakang,
    };
}

class Mahasiswa {
    int idMhsPt;
    String noMhs;
    String namaMahasiswa;
    int kehadiran;

    Mahasiswa({
        required this.idMhsPt,
        required this.noMhs,
        required this.namaMahasiswa,
        required this.kehadiran,
    });

    factory Mahasiswa.fromJson(Map<String, dynamic> json) => Mahasiswa(
        idMhsPt: json["id_mhs_pt"],
        noMhs: json["no_mhs"],
        namaMahasiswa: json["nama_mahasiswa"],
        kehadiran: json["kehadiran"],
    );

    Map<String, dynamic> toJson() => {
        "id_mhs_pt": idMhsPt,
        "no_mhs": noMhs,
        "nama_mahasiswa": namaMahasiswa,
        "kehadiran": kehadiran,
    };
}
