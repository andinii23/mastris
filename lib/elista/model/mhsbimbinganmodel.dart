// To parse this JSON data, do
//
//     final mahasiswaBimbinganElista = mahasiswaBimbinganElistaFromJson(jsonString);

import 'dart:convert';

MahasiswaBimbinganElista mahasiswaBimbinganElistaFromJson(String str) => MahasiswaBimbinganElista.fromJson(json.decode(str));

String mahasiswaBimbinganElistaToJson(MahasiswaBimbinganElista data) => json.encode(data.toJson());

class MahasiswaBimbinganElista {
    int code;
    String errorMessage;
    Data data;

    MahasiswaBimbinganElista({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory MahasiswaBimbinganElista.fromJson(Map<String, dynamic> json) => MahasiswaBimbinganElista(
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
    int angkatan;
    String idProdi;
    String namaProdi;
    String tanggalSuratTugas;
    String stepBimbingan;
    List<DosenPembimbing> dosenPembimbing;

    ListElement({
        required this.idMhsPt,
        required this.nim,
        required this.nama,
        required this.angkatan,
        required this.idProdi,
        required this.namaProdi,
        required this.tanggalSuratTugas,
        required this.stepBimbingan,
        required this.dosenPembimbing,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idMhsPt: json["id_mhs_pt"],
        nim: json["nim"],
        nama: json["nama"],
        angkatan: json["angkatan"],
        idProdi: json["id_prodi"],
        namaProdi: json["nama_prodi"],
        tanggalSuratTugas: json["tanggal_surat_tugas"],
        stepBimbingan: json["step_bimbingan"],
        dosenPembimbing: List<DosenPembimbing>.from(json["dosen_pembimbing"].map((x) => DosenPembimbing.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_mhs_pt": idMhsPt,
        "nim": nim,
        "nama": nama,
        "angkatan": angkatan,
        "id_prodi": idProdi,
        "nama_prodi": namaProdi,
        "tanggal_surat_tugas": tanggalSuratTugas,
        "step_bimbingan": stepBimbingan,
        "dosen_pembimbing": List<dynamic>.from(dosenPembimbing.map((x) => x.toJson())),
    };
}

class DosenPembimbing {
    int idDosen;
    String namaDosen;
    String? gelarDepan;
    String gelarBelakang;
    String jenis;
    String status;
    DateTime? tanggalLulus;
    int? accessDosen;
    int? accSeminarProposal;
    int? accSeminarHasil;
    int? accSidang;
    int? accLulus;

    DosenPembimbing({
        required this.idDosen,
        required this.namaDosen,
        this.gelarDepan,
        required this.gelarBelakang,
        required this.jenis,
        required this.status,
        this.tanggalLulus,
        this.accessDosen,
        this.accSeminarProposal,
        this.accSeminarHasil,
        this.accSidang,
        this.accLulus,
    });

    factory DosenPembimbing.fromJson(Map<String, dynamic> json) => DosenPembimbing(
        idDosen: json["id_dosen"],
        namaDosen: json["nama_dosen"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
        jenis: json["jenis"],
        status: json["status"],
        tanggalLulus: json["tanggal_lulus"] == null ? null : DateTime.parse(json["tanggal_lulus"]),
        accessDosen: json["access_dosen"],
        accSeminarProposal: json["acc_seminar_proposal"],
        accSeminarHasil: json["acc_seminar_hasil"],
        accSidang: json["acc_sidang"],
        accLulus: json["acc_lulus"],
    );

    Map<String, dynamic> toJson() => {
        "id_dosen": idDosen,
        "nama_dosen": namaDosen,
        "gelar_depan": gelarDepan,
        "gelar_belakang": gelarBelakang,
        "jenis": jenis,
        "status": status,
        "tanggal_lulus": "${tanggalLulus!.year.toString().padLeft(4, '0')}-${tanggalLulus!.month.toString().padLeft(2, '0')}-${tanggalLulus!.day.toString().padLeft(2, '0')}",
        "access_dosen": accessDosen,
        "acc_seminar_proposal": accSeminarProposal,
        "acc_seminar_hasil": accSeminarHasil,
        "acc_sidang": accSidang,
        "acc_lulus": accLulus,
    };
}




