// To parse this JSON data, do
//
//     final jenisDataPenelitianModel = jenisDataPenelitianModelFromJson(jsonString);

import 'dart:convert';

List<JenisDataPenelitianModel> jenisDataPenelitianModelFromJson(String str) => List<JenisDataPenelitianModel>.from(json.decode(str).map((x) => JenisDataPenelitianModel.fromJson(x)));

String jenisDataPenelitianModelToJson(List<JenisDataPenelitianModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JenisDataPenelitianModel {
    int? idDataPeneltian;
    String? namaDataPenelitian;

    JenisDataPenelitianModel({
        this.idDataPeneltian,
        this.namaDataPenelitian,
    });

    factory JenisDataPenelitianModel.fromJson(Map<String, dynamic> json) => JenisDataPenelitianModel(
        idDataPeneltian: json["id_data_peneltian"],
        namaDataPenelitian: json["nama_data_penelitian"],
    );

    Map<String, dynamic> toJson() => {
        "id_data_peneltian": idDataPeneltian,
        "nama_data_penelitian": namaDataPenelitian,
    };

      @override

    String toString() => namaDataPenelitian!;
}
