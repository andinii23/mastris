// To parse this JSON data, do
//
//     final dataPenelitianModel = dataPenelitianModelFromJson(jsonString);

import 'dart:convert';

DataPenelitianModel dataPenelitianModelFromJson(String str) => DataPenelitianModel.fromJson(json.decode(str));

String dataPenelitianModelToJson(DataPenelitianModel data) => json.encode(data.toJson());

class DataPenelitianModel {
    int code;
    String errorMessage;
    Data data;

    DataPenelitianModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory DataPenelitianModel.fromJson(Map<String, dynamic> json) => DataPenelitianModel(
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
    String nama;
    String noMhs;
    String judulSkripsi;
    String abstrak;
    int idMetodePenelitian;
    String metodePenelitian;
    int idJenisExplanasi;
    String jenisExplanasi;
    int idJenisDataPenelitian;
    String jenisDataPenelitian;
    int idJenisPenggunaan;
    String jenisPenggunaan;

    ListClass({
        required this.idMhsPt,
        required this.nama,
        required this.noMhs,
        required this.judulSkripsi,
        required this.abstrak,
        required this.idMetodePenelitian,
        required this.metodePenelitian,
        required this.idJenisExplanasi,
        required this.jenisExplanasi,
        required this.idJenisDataPenelitian,
        required this.jenisDataPenelitian,
        required this.idJenisPenggunaan,
        required this.jenisPenggunaan,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        idMhsPt: json["id_mhs_pt"],
        nama: json["nama"],
        noMhs: json["no_mhs"],
        judulSkripsi: json["judul_skripsi"],
        abstrak: json["abstrak"],
        idMetodePenelitian: json["id_metode_penelitian"],
        metodePenelitian: json["metode_penelitian"],
        idJenisExplanasi: json["id_jenis_explanasi"],
        jenisExplanasi: json["jenis_explanasi"],
        idJenisDataPenelitian: json["id_jenis_data_penelitian"],
        jenisDataPenelitian: json["jenis_data_penelitian"],
        idJenisPenggunaan: json["id_jenis_penggunaan"],
        jenisPenggunaan: json["jenis_penggunaan"],
    );

    Map<String, dynamic> toJson() => {
        "id_mhs_pt": idMhsPt,
        "nama": nama,
        "no_mhs": noMhs,
        "judul_skripsi": judulSkripsi,
        "abstrak": abstrak,
        "id_metode_penelitian": idMetodePenelitian,
        "metode_penelitian": metodePenelitian,
        "id_jenis_explanasi": idJenisExplanasi,
        "jenis_explanasi": jenisExplanasi,
        "id_jenis_data_penelitian": idJenisDataPenelitian,
        "jenis_data_penelitian": jenisDataPenelitian,
        "id_jenis_penggunaan": idJenisPenggunaan,
        "jenis_penggunaan": jenisPenggunaan,
    };
}
