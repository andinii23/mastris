// To parse this JSON data, do
//
//     final detailMhsBimbinganModel = detailMhsBimbinganModelFromJson(jsonString);

import 'dart:convert';

DetailMhsBimbinganModel detailMhsBimbinganModelFromJson(String str) => DetailMhsBimbinganModel.fromJson(json.decode(str));

String detailMhsBimbinganModelToJson(DetailMhsBimbinganModel data) => json.encode(data.toJson());

class DetailMhsBimbinganModel {
    int code;
    String errorMessage;
    Data data;

    DetailMhsBimbinganModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory DetailMhsBimbinganModel.fromJson(Map<String, dynamic> json) => DetailMhsBimbinganModel(
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
    int idMhsPt;
    String nim;
    String nama;
    int angkatan;
    String idProdi;
    String namaProdi;
    List<DosenPembimbing> dosenPembimbing;
    Penelitian penelitian;
    List<dynamic> fileSkripsi;
    List<AgendaBimbingan> agendaBimbingan;

    ListClass({
        required this.idMhsPt,
        required this.nim,
        required this.nama,
        required this.angkatan,
        required this.idProdi,
        required this.namaProdi,
        required this.dosenPembimbing,
        required this.penelitian,
        required this.fileSkripsi,
        required this.agendaBimbingan,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        idMhsPt: json["id_mhs_pt"],
        nim: json["nim"],
        nama: json["nama"],
        angkatan: json["angkatan"],
        idProdi: json["id_prodi"],
        namaProdi: json["nama_prodi"],
        dosenPembimbing: List<DosenPembimbing>.from(json["dosen_pembimbing"].map((x) => DosenPembimbing.fromJson(x))),
        penelitian: Penelitian.fromJson(json["penelitian"]),
        fileSkripsi: List<dynamic>.from(json["file_skripsi"].map((x) => x)),
        agendaBimbingan: List<AgendaBimbingan>.from(json["agenda_bimbingan"].map((x) => AgendaBimbingan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_mhs_pt": idMhsPt,
        "nim": nim,
        "nama": nama,
        "angkatan": angkatan,
        "id_prodi": idProdi,
        "nama_prodi": namaProdi,
        "dosen_pembimbing": List<dynamic>.from(dosenPembimbing.map((x) => x.toJson())),
        "penelitian": penelitian.toJson(),
        "file_skripsi": List<dynamic>.from(fileSkripsi.map((x) => x)),
        "agenda_bimbingan": List<dynamic>.from(agendaBimbingan.map((x) => x.toJson())),
    };
}

class AgendaBimbingan {
    int idAgendaBimbingan;
    String tanggal;
    String jenisBimbingan;
    String permasalahan;
    dynamic solusi;

    AgendaBimbingan({
        required this.idAgendaBimbingan,
        required this.tanggal,
        required this.jenisBimbingan,
        required this.permasalahan,
        this.solusi,
    });

    factory AgendaBimbingan.fromJson(Map<String, dynamic> json) => AgendaBimbingan(
        idAgendaBimbingan: json["id_agenda_bimbingan"],
        tanggal: json["tanggal"],
        jenisBimbingan: json["jenis_bimbingan"],
        permasalahan: json["permasalahan"],
        solusi: json["solusi"],
    );

    Map<String, dynamic> toJson() => {
        "id_agenda_bimbingan": idAgendaBimbingan,
        "tanggal": tanggal,
        "jenis_bimbingan": jenisBimbingan,
        "permasalahan": permasalahan,
        "solusi": solusi,
    };
}

class DosenPembimbing {
    String jenis;
    int idDosen;
    String namaDosen;
    String? gelarDepan;
    String gelarBelakang;

    DosenPembimbing({
        required this.jenis,
        required this.idDosen,
        required this.namaDosen,
        this.gelarDepan,
        required this.gelarBelakang,
    });

    factory DosenPembimbing.fromJson(Map<String, dynamic> json) => DosenPembimbing(
        jenis: json["jenis"],
        idDosen: json["id_dosen"],
        namaDosen: json["nama_dosen"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
    );

    Map<String, dynamic> toJson() => {
        "jenis": jenis,
        "id_dosen": idDosen,
        "nama_dosen": namaDosen,
        "gelar_depan": gelarDepan,
        "gelar_belakang": gelarBelakang,
    };
}

class Penelitian {
    String judulSkripsi;
    String abstrak;
    String metodePenelitian;
    String jenisExplanasi;
    String jenisDataPenelitian;
    String jenisPenggunaan;

    Penelitian({
        required this.judulSkripsi,
        required this.abstrak,
        required this.metodePenelitian,
        required this.jenisExplanasi,
        required this.jenisDataPenelitian,
        required this.jenisPenggunaan,
    });

    factory Penelitian.fromJson(Map<String, dynamic> json) => Penelitian(
        judulSkripsi: json["judul_skripsi"],
        abstrak: json["abstrak"],
        metodePenelitian: json["metode_penelitian"],
        jenisExplanasi: json["jenis_explanasi"],
        jenisDataPenelitian: json["jenis_data_penelitian"],
        jenisPenggunaan: json["jenis_penggunaan"],
    );

    Map<String, dynamic> toJson() => {
        "judul_skripsi": judulSkripsi,
        "abstrak": abstrak,
        "metode_penelitian": metodePenelitian,
        "jenis_explanasi": jenisExplanasi,
        "jenis_data_penelitian": jenisDataPenelitian,
        "jenis_penggunaan": jenisPenggunaan,
    };
}
