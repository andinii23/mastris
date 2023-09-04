// To parse this JSON data, do
//
//     final metodePenelitianModel = metodePenelitianModelFromJson(jsonString);

import 'dart:convert';

List<MetodePenelitianModel> metodePenelitianModelFromJson(String str) => List<MetodePenelitianModel>.from(json.decode(str).map((x) => MetodePenelitianModel.fromJson(x)));

String metodePenelitianModelToJson(List<MetodePenelitianModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MetodePenelitianModel {
    int? idMetodePenelitian;
    String? namaMetodePenelitian;

    MetodePenelitianModel({
        this.idMetodePenelitian,
        this.namaMetodePenelitian,
    });

    factory MetodePenelitianModel.fromJson(Map<String, dynamic> json) => MetodePenelitianModel(
        idMetodePenelitian: json["id_metode_penelitian"],
        namaMetodePenelitian: json["nama_metode_penelitian"],
    );

    Map<String, dynamic> toJson() => {
        "id_metode_penelitian": idMetodePenelitian,
        "nama_metode_penelitian": namaMetodePenelitian,
    };
}
