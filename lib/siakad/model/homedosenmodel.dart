// To parse this JSON data, do
//
//     final homeDosenModel = homeDosenModelFromJson(jsonString);

import 'dart:convert';

HomeDosenModel homeDosenModelFromJson(String str) =>
    HomeDosenModel.fromJson(json.decode(str));

String homeDosenModelToJson(HomeDosenModel data) => json.encode(data.toJson());

class HomeDosenModel {
  HomeDosenModel({
    required this.code,
    required this.errorMessage,
    required this.data,
  });

  int code;
  String errorMessage;
  Data data;

  factory HomeDosenModel.fromJson(Map<String, dynamic> json) => HomeDosenModel(
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
  Data({
    required this.total,
    required this.perPage,
    required this.page,
    required this.list,
  });

  int total;
  int perPage;
  int page;
  ListClass list;

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
  ListClass({
    this.idDosen,
    required this.namaDosen,
    this.gelarDepan,
    required this.gelarBelakang,
    required this.lokasiPresensi,
    required this.prodi,
    this.foto,
    required this.fakultas,
    required this.mahasiswaBimbinganAkademik,
  });

  dynamic idDosen;
  String namaDosen;
  dynamic gelarDepan;
  String gelarBelakang;
  String lokasiPresensi;
  Prodi prodi;
  dynamic foto;
  Fakultas fakultas;
  List<MahasiswaBimbinganAkademik> mahasiswaBimbinganAkademik;

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        idDosen: json["id_dosen"],
        namaDosen: json["nama_dosen"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
        lokasiPresensi: json["lokasi_presensi"],
        prodi: Prodi.fromJson(json["prodi"]),
        foto: json["foto"],
        fakultas: Fakultas.fromJson(json["fakultas"]),
        mahasiswaBimbinganAkademik: List<MahasiswaBimbinganAkademik>.from(
            json["mahasiswa_bimbingan_akademik"]
                .map((x) => MahasiswaBimbinganAkademik.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_dosen": idDosen,
        "nama_dosen": namaDosen,
        "gelar_depan": gelarDepan,
        "gelar_belakang": gelarBelakang,
        "lokasi_presensi": lokasiPresensi,
        "prodi": prodi.toJson(),
        "foto": foto,
        "fakultas": fakultas.toJson(),
        "mahasiswa_bimbingan_akademik": List<dynamic>.from(
            mahasiswaBimbinganAkademik.map((x) => x.toJson())),
      };
}

class Fakultas {
  Fakultas({
    required this.idFakultas,
    required this.namaFakultas,
  });

  int idFakultas;
  String namaFakultas;

  factory Fakultas.fromJson(Map<String, dynamic> json) => Fakultas(
        idFakultas: json["id_fakultas"],
        namaFakultas: json["nama_fakultas"],
      );

  Map<String, dynamic> toJson() => {
        "id_fakultas": idFakultas,
        "nama_fakultas": namaFakultas,
      };
}

class MahasiswaBimbinganAkademik {
  MahasiswaBimbinganAkademik({
    required this.idPembimbingAkademik,
    required this.idMhsPt,
    required this.idDosen,
    required this.noMahasiswa,
    required this.idStatusMahasiswa,
    required this.namaMahasiswa,
  });

  int idPembimbingAkademik;
  int idMhsPt;
  int idDosen;
  String noMahasiswa;
  IdStatusMahasiswa idStatusMahasiswa;
  String namaMahasiswa;

  factory MahasiswaBimbinganAkademik.fromJson(Map<String, dynamic> json) =>
      MahasiswaBimbinganAkademik(
        idPembimbingAkademik: json["id_pembimbing_akademik"],
        idMhsPt: json["id_mhs_pt"],
        idDosen: json["id_dosen"],
        noMahasiswa: json["no_mahasiswa"],
        idStatusMahasiswa:
            idStatusMahasiswaValues.map[json["id_status_mahasiswa"]]!,
        namaMahasiswa: json["nama_mahasiswa"],
      );

  Map<String, dynamic> toJson() => {
        "id_pembimbing_akademik": idPembimbingAkademik,
        "id_mhs_pt": idMhsPt,
        "id_dosen": idDosen,
        "no_mahasiswa": noMahasiswa,
        "id_status_mahasiswa":
            idStatusMahasiswaValues.reverse[idStatusMahasiswa],
        "nama_mahasiswa": namaMahasiswa,
      };
}

enum IdStatusMahasiswa { A }

final idStatusMahasiswaValues = EnumValues({"A": IdStatusMahasiswa.A});

class Prodi {
  Prodi({
    required this.idProdi,
    required this.namaProdi,
  });

  String idProdi;
  String namaProdi;

  factory Prodi.fromJson(Map<String, dynamic> json) => Prodi(
        idProdi: json["id_prodi"],
        namaProdi: json["nama_prodi"],
      );

  Map<String, dynamic> toJson() => {
        "id_prodi": idProdi,
        "nama_prodi": namaProdi,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
