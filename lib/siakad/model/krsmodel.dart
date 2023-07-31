// To parse this JSON data, do
//
//     final krsModel = krsModelFromJson(jsonString);

import 'dart:convert';

KrsModel krsModelFromJson(String str) => KrsModel.fromJson(json.decode(str));

String krsModelToJson(KrsModel data) => json.encode(data.toJson());

class KrsModel {
  int code;
  String errorMessage;
  Data data;

  KrsModel({
    required this.code,
    required this.errorMessage,
    required this.data,
  });

  factory KrsModel.fromJson(Map<String, dynamic> json) => KrsModel(
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
  String? idSemester;
  int jumlahSksKontrak;
  String? ipSebelumnya;
  dynamic status;
  String? statusText;
  int? maxSks;
  String awalKrs;
  String akhirKrs;
  dynamic awalKprs;
  dynamic akhirKprs;
  List<ListPesanKr> listPesanKrs;
  List<ListKr> listKrs;

  ListClass({
    this.idSemester,
    required this.jumlahSksKontrak,
    this.ipSebelumnya,
    this.status,
    this.statusText,
    this.maxSks,
    required this.awalKrs,
    required this.akhirKrs,
     this.awalKprs,
     this.akhirKprs,
    required this.listPesanKrs,
    required this.listKrs,
  });

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        idSemester: json["id_semester"],
        jumlahSksKontrak: json["jumlah_sks_kontrak"],
        ipSebelumnya: json["ip_sebelumnya"],
        status: json["status"],
        statusText: json["status_text"],
        maxSks: json["max_sks"],
        awalKrs: json["awal_krs"],
        akhirKrs: json["akhir_krs"],
        awalKprs: json["awal_kprs"],
        akhirKprs: json["akhir_kprs"],
        listPesanKrs: List<ListPesanKr>.from(
            json["list_pesan_krs"].map((x) => ListPesanKr.fromJson(x))),
        listKrs:
            List<ListKr>.from(json["list_krs"].map((x) => ListKr.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_semester": idSemester,
        "jumlah_sks_kontrak": jumlahSksKontrak,
        "ip_sebelumnya": ipSebelumnya,
        "status": status,
        "status_text": statusText,
        "max_sks": maxSks,
        "awal_krs": awalKrs,
        "akhir_krs": akhirKrs,
        "awal_kprs": awalKprs,
        "akhir_kprs": akhirKprs,
        "list_pesan_krs":
            List<dynamic>.from(listPesanKrs.map((x) => x.toJson())),
        "list_krs": List<dynamic>.from(listKrs.map((x) => x.toJson())),
      };
}

class ListKr {
  int? idKrs;
  String? status;
  dynamic mbkm;
  Matakuliah matakuliah;
  Kelas? kelas;
  List<Dosen> dosen;

  ListKr({
    this.idKrs,
    this.status,
    this.mbkm,
    required this.matakuliah,
    this.kelas,
    required this.dosen,
  });

  factory ListKr.fromJson(Map<String, dynamic> json) => ListKr(
        idKrs: json["id_krs"],
        status: json["status"],
        mbkm: json["mbkm"],
        matakuliah: Matakuliah.fromJson(json["matakuliah"]),
        kelas: json["kelas"] == null ? null : Kelas.fromJson(json["kelas"]),
        dosen: List<Dosen>.from(json["dosen"].map((x) => Dosen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_krs": idKrs,
        "status": status,
        "mbkm": mbkm,
        "matakuliah": matakuliah.toJson(),
        "kelas": kelas?.toJson(),
        "dosen": List<dynamic>.from(dosen.map((x) => x.toJson())),
      };
}

class Dosen {
  int? idDosen;
  String? namaDosen;
  dynamic gelarDepan;
  String? gelarBelakang;

  Dosen({
    this.idDosen,
    this.namaDosen,
    this.gelarDepan,
    this.gelarBelakang,
  });

  factory Dosen.fromJson(Map<String, dynamic> json) => Dosen(
        idDosen: json["id_dosen"],
        namaDosen: json["nama_dosen"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
      );

  Map<String, dynamic> toJson() => {
        "id_dosen": idDosen,
        "nama_dosen": namaDosen,
        "gelar_depan": gelarDepan,
        "gelar_belakang": gelarBelakang,
      };
}

class Kelas {
  int? idKelas;
  String? kodeKelas;
  String? jamMulai;
  String? jamSelesai;
  String? hari;
  RuangKuliah ruangKuliah;

  Kelas({
     this.idKelas,
     this.kodeKelas,
     this.jamMulai,
     this.jamSelesai,
     this.hari,
    required this.ruangKuliah,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) => Kelas(
        idKelas: json["id_kelas"],
        kodeKelas: json["kode_kelas"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        hari: json["hari"],
        ruangKuliah: RuangKuliah.fromJson(json["ruang_kuliah"]),
      );

  Map<String, dynamic> toJson() => {
        "id_kelas": idKelas,
        "kode_kelas": kodeKelas,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "hari": hari,
        "ruang_kuliah": ruangKuliah.toJson(),
      };
}

class RuangKuliah {
  String? namaRuang;

  RuangKuliah({
    this.namaRuang,
  });

  factory RuangKuliah.fromJson(Map<String, dynamic> json) => RuangKuliah(
        namaRuang: json["nama_ruang"],
      );

  Map<String, dynamic> toJson() => {
        "nama_ruang": namaRuang,
      };
}

class Matakuliah {
  int? idMatakuliah;
  String kodeMatakuliah;
  String namaMatakuliah;
  String? sksTotal;

  Matakuliah({
    this.idMatakuliah,
    required this.kodeMatakuliah,
    required this.namaMatakuliah,
    this.sksTotal,
  });

  factory Matakuliah.fromJson(Map<String, dynamic> json) => Matakuliah(
        idMatakuliah: json["id_matakuliah"],
        kodeMatakuliah: json["kode_matakuliah"],
        namaMatakuliah: json["nama_matakuliah"],
        sksTotal: json["sks_total"],
      );

  Map<String, dynamic> toJson() => {
        "id_matakuliah": idMatakuliah,
        "kode_matakuliah": kodeMatakuliah,
        "nama_matakuliah": namaMatakuliah,
        "sks_total": sksTotal,
      };
}

class ListPesanKr {
  int? idPengirim;
  int? idPenerima;
  String tanggal;
  String? idSemester;
  String pesan;

  ListPesanKr({
     this.idPengirim,
     this.idPenerima,
    required this.tanggal,
    this.idSemester,
    required this.pesan,
  });

  factory ListPesanKr.fromJson(Map<String, dynamic> json) => ListPesanKr(
        idPengirim: json["id_pengirim"],
        idPenerima: json["id_penerima"],
        tanggal: json["tanggal"],
        idSemester: json["id_semester"],
        pesan: json["pesan"],
      );

  Map<String, dynamic> toJson() => {
        "id_pengirim": idPengirim,
        "id_penerima": idPenerima,
        "tanggal": tanggal,
        "id_semester": idSemester,
        "pesan": pesan,
      };
}
