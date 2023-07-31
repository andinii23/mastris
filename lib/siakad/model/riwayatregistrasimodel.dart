// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.code,
    required this.errorMessage,
    required this.data,
  });

  int code;
  String errorMessage;
  Data data;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
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
  List<ListElement> list;

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
  ListElement({
    required this.idSemester,
    required this.semesterText,
    this.statusReg,
    required this.tglDaftar,
    required this.ipk,
    required this.ips,
    this.idTagihan,
    this.ukt,
    required this.statusMahasiswa,
    required this.statusMahasiswaText,

  });

  String idSemester;
  String semesterText;
  String? statusReg;
  DateTime tglDaftar;
  String ipk;
  String ips;
  String? idTagihan;
  dynamic ukt;
  String statusMahasiswa;
  String statusMahasiswaText;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idSemester: json["id_semester"],
        semesterText: json["semester_text"],
        statusReg: json["status_reg"],
        tglDaftar: DateTime.parse(json["tgl_daftar"]),
        ipk: json["ipk"],
        ips: json["ips"],
        idTagihan: json["id_tagihan"],
        ukt: json["ukt"],
        statusMahasiswa: json["status_mahasiswa"],
        statusMahasiswaText: json["status_mahasiswa_text"],
      );

  Map<String, dynamic> toJson() => {
        "id_semester": idSemester,
        "semester_text": semesterText,
        "status_reg": statusReg,
        "tgl_daftar": tglDaftar.toIso8601String(),
        "ipk": ipk,
        "ips": ips,
        "id_tagihan": idTagihan,
        "ukt": ukt,
        "status_mahasiswa": statusMahasiswa,
        "status_mahasiswa_text": statusMahasiswaText,
      };
}
