// To parse this JSON data, do
//
//     final prosesBimbinganModel = prosesBimbinganModelFromJson(jsonString);

import 'dart:convert';

ProsesBimbinganModel prosesBimbinganModelFromJson(String str) => ProsesBimbinganModel.fromJson(json.decode(str));

String prosesBimbinganModelToJson(ProsesBimbinganModel data) => json.encode(data.toJson());

class ProsesBimbinganModel {
    int code;
    String errorMessage;
    Data data;

    ProsesBimbinganModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory ProsesBimbinganModel.fromJson(Map<String, dynamic> json) => ProsesBimbinganModel(
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
    List<ListStepDilewati> listStepDilewati;
    dynamic stepSaatIni;

    ListClass({
        required this.listStepDilewati,
        required this.stepSaatIni,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        listStepDilewati: List<ListStepDilewati>.from(json["list_step_dilewati"].map((x) => ListStepDilewati.fromJson(x))),
        stepSaatIni: json["step_saat_ini"],
    );

    Map<String, dynamic> toJson() => {
        "list_step_dilewati": List<dynamic>.from(listStepDilewati.map((x) => x.toJson())),
        "step_saat_ini": stepSaatIni,
    };
}

class ListStepDilewati {
    int idStepBimbingan;
    int step;
    int seqnum;
    String namaStep;
    String keterangan;
    DateTime tanggal;
    String jam;
    int lamaHari;
    int lamaHariKeseluruhan;

    ListStepDilewati({
        required this.idStepBimbingan,
        required this.step,
        required this.seqnum,
        required this.namaStep,
        required this.keterangan,
        required this.tanggal,
        required this.jam,
        required this.lamaHari,
        required this.lamaHariKeseluruhan,
    });

    factory ListStepDilewati.fromJson(Map<String, dynamic> json) => ListStepDilewati(
        idStepBimbingan: json["id_step_bimbingan"],
        step: json["step"],
        seqnum: json["seqnum"],
        namaStep: json["nama_step"],
        keterangan: json["keterangan"],
        tanggal: DateTime.parse(json["tanggal"]),
        jam: json["jam"],
        lamaHari: json["lama_hari"],
        lamaHariKeseluruhan: json["lama_hari_keseluruhan"],
    );

    Map<String, dynamic> toJson() => {
        "id_step_bimbingan": idStepBimbingan,
        "step": step,
        "seqnum": seqnum,
        "nama_step": namaStep,
        "keterangan": keterangan,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "jam": jam,
        "lama_hari": lamaHari,
        "lama_hari_keseluruhan": lamaHariKeseluruhan,
    };
}
