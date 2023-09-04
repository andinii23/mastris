// To parse this JSON data, do
//
//     final ketSemesterModel = ketSemesterModelFromJson(jsonString);

import 'dart:convert';

KetSemesterModel ketSemesterModelFromJson(String str) => KetSemesterModel.fromJson(json.decode(str));

String ketSemesterModelToJson(KetSemesterModel data) => json.encode(data.toJson());

class KetSemesterModel {
    int code;
    String errorMessage;
    Data data;

    KetSemesterModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory KetSemesterModel.fromJson(Map<String, dynamic> json) => KetSemesterModel(
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
    String idSemester;
    int periodeAktif;
    DateTime? tglMulai;
    DateTime? tglSelesai;
    DateTime? akhirPelaporan;
    DateTime? updateDate;
    String? updateBy;
    String createDate;
    String? createBy;
    int sinkronFeeder;
    int openEregis;
    DateTime? openRegis;
    DateTime? closeRegis;
    int semesterYudisiumAktif;
    int smtAktifSiakadeka;
    int smtAktifPpg;
    int openRegisMhsBaru;
    int smtAktifElista;
    int semAktifSister;
    String semesterText;

    ListElement({
        required this.idSemester,
        required this.periodeAktif,
        required this.tglMulai,
        required this.tglSelesai,
        required this.akhirPelaporan,
        required this.updateDate,
        required this.updateBy,
        required this.createDate,
        required this.createBy,
        required this.sinkronFeeder,
        required this.openEregis,
        required this.openRegis,
        required this.closeRegis,
        required this.semesterYudisiumAktif,
        required this.smtAktifSiakadeka,
        required this.smtAktifPpg,
        required this.openRegisMhsBaru,
        required this.smtAktifElista,
        required this.semAktifSister,
        required this.semesterText,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idSemester: json["id_semester"],
        periodeAktif: json["periode_aktif"],
        tglMulai: json["tgl_mulai"] == null ? null : DateTime.parse(json["tgl_mulai"]),
        tglSelesai: json["tgl_selesai"] == null ? null : DateTime.parse(json["tgl_selesai"]),
        akhirPelaporan: json["akhir_pelaporan"] == null ? null : DateTime.parse(json["akhir_pelaporan"]),
        updateDate: json["update_date"] == null ? null : DateTime.parse(json["update_date"]),
        updateBy: json["update_by"],
        createDate: json["create_date"],
        createBy: json["create_by"],
        sinkronFeeder: json["sinkron_feeder"],
        openEregis: json["open_eregis"],
        openRegis: json["open_regis"] == null ? null : DateTime.parse(json["open_regis"]),
        closeRegis: json["close_regis"] == null ? null : DateTime.parse(json["close_regis"]),
        semesterYudisiumAktif: json["semester_yudisium_aktif"],
        smtAktifSiakadeka: json["smt_aktif_siakadeka"],
        smtAktifPpg: json["smt_aktif_ppg"],
        openRegisMhsBaru: json["open_regis_mhs_baru"],
        smtAktifElista: json["smt_aktif_elista"],
        semAktifSister: json["sem_aktif_sister"],
        semesterText: json["semester_text"],
    );

    Map<String, dynamic> toJson() => {
        "id_semester": idSemester,
        "periode_aktif": periodeAktif,
        "tgl_mulai": "${tglMulai!.year.toString().padLeft(4, '0')}-${tglMulai!.month.toString().padLeft(2, '0')}-${tglMulai!.day.toString().padLeft(2, '0')}",
        "tgl_selesai": "${tglSelesai!.year.toString().padLeft(4, '0')}-${tglSelesai!.month.toString().padLeft(2, '0')}-${tglSelesai!.day.toString().padLeft(2, '0')}",
        "akhir_pelaporan": "${akhirPelaporan!.year.toString().padLeft(4, '0')}-${akhirPelaporan!.month.toString().padLeft(2, '0')}-${akhirPelaporan!.day.toString().padLeft(2, '0')}",
        "update_date": updateDate?.toIso8601String(),
        "update_by": updateBy,
        "create_date": createDate,
        "create_by": createBy,
        "sinkron_feeder": sinkronFeeder,
        "open_eregis": openEregis,
        "open_regis": openRegis?.toIso8601String(),
        "close_regis": closeRegis?.toIso8601String(),
        "semester_yudisium_aktif": semesterYudisiumAktif,
        "smt_aktif_siakadeka": smtAktifSiakadeka,
        "smt_aktif_ppg": smtAktifPpg,
        "open_regis_mhs_baru": openRegisMhsBaru,
        "smt_aktif_elista": smtAktifElista,
        "sem_aktif_sister": semAktifSister,
        "semester_text": semesterText,
    };
}
