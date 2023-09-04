// To parse this JSON data, do
//
//     final jenisExplanasiModel = jenisExplanasiModelFromJson(jsonString);

import 'dart:convert';

List<JenisExplanasiModel> jenisExplanasiModelFromJson(String str) => List<JenisExplanasiModel>.from(json.decode(str).map((x) => JenisExplanasiModel.fromJson(x)));

String jenisExplanasiModelToJson(List<JenisExplanasiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JenisExplanasiModel {
    int? idJenisExplanasi;
    String? namaJenisExplanasi;

    JenisExplanasiModel({
        this.idJenisExplanasi,
        this.namaJenisExplanasi,
    });

    factory JenisExplanasiModel.fromJson(Map<String, dynamic> json) => JenisExplanasiModel(
        idJenisExplanasi: json["id_jenis_explanasi"],
        namaJenisExplanasi: json["nama_jenis_explanasi"],
    );

    Map<String, dynamic> toJson() => {
        "id_jenis_explanasi": idJenisExplanasi,
        "nama_jenis_explanasi": namaJenisExplanasi,
    };
}
