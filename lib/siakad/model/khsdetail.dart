// To parse this JSON data, do
//
//     final khsDetailModel = khsDetailModelFromJson(jsonString);

import 'dart:convert';

KhsDetailModel khsDetailModelFromJson(String str) =>
    KhsDetailModel.fromJson(json.decode(str));

String khsDetailModelToJson(KhsDetailModel data) => json.encode(data.toJson());

class KhsDetailModel {
  int code;
  String errorMessage;
  Data data;

  KhsDetailModel({
    required this.code,
    required this.errorMessage,
    required this.data,
  });

  factory KhsDetailModel.fromJson(Map<String, dynamic> json) => KhsDetailModel(
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
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "per_page": perPage,
        "page": page,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  int? idSemester;
  String? semesterText;
  String? ip;
  String? sksSemester;
  List<ListMataKuliah> listMataKuliah;

  ListElement({
    this.idSemester,
    this.semesterText,
    this.ip,
    this.sksSemester,
    required this.listMataKuliah,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idSemester: json["id_semester"],
        semesterText: json["semester_text"],
        ip: json["ip"],
        sksSemester: json["sks_semester"],
        listMataKuliah: List<ListMataKuliah>.from(
            json["list_mata_kuliah"].map((x) => ListMataKuliah.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_semester": idSemester,
        "semester_text": semesterText,
        "ip": ip,
        "sks_semester": sksSemester,
        "list_mata_kuliah":
            List<dynamic>.from(listMataKuliah.map((x) => x.toJson())),
      };
}

class ListMataKuliah {
  int? idKrs;
  String? status;
  int? idSemester;
  dynamic nilai;
  int? idMhsPt;
  dynamic edom;
  dynamic statusKrs;
  int? idMatakuliah;
  String? namaMatakuliah;
  String? kodeMatakuliah;
  String? sksTotal;
  String? kodeKelas;
  int? idKelas;
  String? jamMulai;
  String? jamSelesai;
  int? hari;
  int? idKelasProdi;
  String? semester;
  String? namaRuang;
  dynamic idPaketMbkm;
  dynamic namaPaketProgram;
  dynamic namaProgramMbkm;
  dynamic namaKelasProdi;
  String? idProdi;
  String? namaProdi;
  String? semesterText;

  ListMataKuliah({
    this.idKrs,
    this.status,
    this.idSemester,
    this.nilai,
    this.idMhsPt,
    this.edom,
    this.statusKrs,
    this.idMatakuliah,
    this.namaMatakuliah,
    this.kodeMatakuliah,
    this.sksTotal,
    this.kodeKelas,
    this.idKelas,
    this.jamMulai,
    this.jamSelesai,
    this.hari,
    this.idKelasProdi,
    this.semester,
    this.namaRuang,
    this.idPaketMbkm,
    this.namaPaketProgram,
    this.namaProgramMbkm,
    this.namaKelasProdi,
    this.idProdi,
    this.namaProdi,
    this.semesterText,
  });

  factory ListMataKuliah.fromJson(Map<String, dynamic> json) => ListMataKuliah(
        idKrs: json["id_krs"],
        status: json["status"],
        idSemester: json["id_semester"],
        nilai: json["nilai"],
        idMhsPt: json["id_mhs_pt"],
        edom: json["edom"],
        statusKrs: json["status_krs"],
        idMatakuliah: json["id_matakuliah"],
        namaMatakuliah: json["nama_matakuliah"],
        kodeMatakuliah: json["kode_matakuliah"],
        sksTotal: json["sks_total"],
        kodeKelas: json["kode_kelas"],
        idKelas: json["id_kelas"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        hari: json["hari"],
        idKelasProdi: json["id_kelas_prodi"],
        semester: json["semester"],
        namaRuang: json["nama_ruang"],
        idPaketMbkm: json["id_paket_mbkm"],
        namaPaketProgram: json["nama_paket_program"],
        namaProgramMbkm: json["nama_program_mbkm"],
        namaKelasProdi: json["nama_kelas_prodi"],
        idProdi: json["id_prodi"],
        namaProdi: json["nama_prodi"],
        semesterText: json["semester_text"],
      );

  Map<String, dynamic> toJson() => {
        "id_krs": idKrs,
        "status": status,
        "id_semester": idSemester,
        "nilai": nilai,
        "id_mhs_pt": idMhsPt,
        "edom": edom,
        "status_krs": statusKrs,
        "id_matakuliah": idMatakuliah,
        "nama_matakuliah": namaMatakuliah,
        "kode_matakuliah": kodeMatakuliah,
        "sks_total": sksTotal,
        "kode_kelas": kodeKelas,
        "id_kelas": idKelas,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "hari": hari,
        "id_kelas_prodi": idKelasProdi,
        "semester": semester,
        "nama_ruang": namaRuang,
        "id_paket_mbkm": idPaketMbkm,
        "nama_paket_program": namaPaketProgram,
        "nama_program_mbkm": namaProgramMbkm,
        "nama_kelas_prodi": namaKelasProdi,
        "id_prodi": idProdi,
        "nama_prodi": namaProdi,
        "semester_text": semesterText,
      };
}
