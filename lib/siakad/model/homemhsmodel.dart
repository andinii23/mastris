// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
    int code;
    String errorMessage;
    Data data;

    HomeModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
    String noMahasiswa;
    String namaMahasiswa;
    String statusMahasiswa;
    String statusMahasiswaText;
    String angkatan;
    dynamic ipk;
    dynamic ipSebelumnya;
    String foto;
    int semester;
    Prodi prodi;
    DosenPa dosenPa;

    ListClass({
        required this.idMhsPt,
        required this.noMahasiswa,
        required this.namaMahasiswa,
        required this.statusMahasiswa,
        required this.statusMahasiswaText,
        required this.angkatan,
        required this.ipk,
        required this.ipSebelumnya,
        required this.foto,
        required this.semester,
        required this.prodi,
        required this.dosenPa,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        idMhsPt: json["id_mhs_pt"],
        noMahasiswa: json["no_mahasiswa"],
        namaMahasiswa: json["nama_mahasiswa"],
        statusMahasiswa: json["status_mahasiswa"],
        statusMahasiswaText: json["status_mahasiswa_text"],
        angkatan: json["angkatan"],
        ipk: json["ipk"],
        ipSebelumnya: json["ip_sebelumnya"],
        foto: json["foto"],
        semester: json["semester"],
        prodi: Prodi.fromJson(json["prodi"]),
        dosenPa: DosenPa.fromJson(json["dosen_pa"]),
    );

    Map<String, dynamic> toJson() => {
        "id_mhs_pt": idMhsPt,
        "no_mahasiswa": noMahasiswa,
        "nama_mahasiswa": namaMahasiswa,
        "status_mahasiswa": statusMahasiswa,
        "status_mahasiswa_text": statusMahasiswaText,
        "angkatan": angkatan,
        "ipk": ipk,
        "ip_sebelumnya": ipSebelumnya,
        "foto": foto,
        "semester": semester,
        "prodi": prodi.toJson(),
        "dosen_pa": dosenPa.toJson(),
    };
}

class DosenPa {
    int idPegawai;
    String namaPegawai;
    dynamic gelarDepan;
    String gelarBelakang;

    DosenPa({
        required this.idPegawai,
        required this.namaPegawai,
        this.gelarDepan,
        required this.gelarBelakang,
    });

    factory DosenPa.fromJson(Map<String, dynamic> json) => DosenPa(
        idPegawai: json["id_pegawai"],
        namaPegawai: json["nama_pegawai"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
    );

    Map<String, dynamic> toJson() => {
        "id_pegawai": idPegawai,
        "nama_pegawai": namaPegawai,
        "gelar_depan": gelarDepan,
        "gelar_belakang": gelarBelakang,
    };
}

class Prodi {
    String idProdi;
    String namaProdi;
    String kelas;
    Fakultas fakultas;
    Jurusan jurusan;

    Prodi({
        required this.idProdi,
        required this.namaProdi,
        required this.kelas,
        required this.fakultas,
        required this.jurusan,
    });

    factory Prodi.fromJson(Map<String, dynamic> json) => Prodi(
        idProdi: json["id_prodi"],
        namaProdi: json["nama_prodi"],
        kelas: json["kelas"],
        fakultas: Fakultas.fromJson(json["fakultas"]),
        jurusan: Jurusan.fromJson(json["jurusan"]),
    );

    Map<String, dynamic> toJson() => {
        "id_prodi": idProdi,
        "nama_prodi": namaProdi,
        "kelas": kelas,
        "fakultas": fakultas.toJson(),
        "jurusan": jurusan.toJson(),
    };
}

class Fakultas {
    dynamic idFakultas;
    dynamic namaFakultas;

    Fakultas({
        this.idFakultas,
        this.namaFakultas,
    });

    factory Fakultas.fromJson(Map<String, dynamic> json) => Fakultas(
        idFakultas: json["id_fakultas"],
        namaFakultas: json["nama_fakultas"],
    );

    Map<String, dynamic> toJson() => {
        "id_fakultas": idFakultas,
        "nama_fakultas": namaFakultas,
    };
}

class Jurusan {
    dynamic idJurusan;
    dynamic namaJurusan;

    Jurusan({
        this.idJurusan,
        this.namaJurusan,
    });

    factory Jurusan.fromJson(Map<String, dynamic> json) => Jurusan(
        idJurusan: json["id_jurusan"],
        namaJurusan: json["nama_jurusan"],
    );

    Map<String, dynamic> toJson() => {
        "id_jurusan": idJurusan,
        "nama_jurusan": namaJurusan,
    };
}
