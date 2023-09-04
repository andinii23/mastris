// To parse this JSON data, do
//
//     final jenisPenggunaanModel = jenisPenggunaanModelFromJson(jsonString);

import 'dart:convert';

List<JenisPenggunaanModel> jenisPenggunaanModelFromJson(String str) => List<JenisPenggunaanModel>.from(json.decode(str).map((x) => JenisPenggunaanModel.fromJson(x)));

String jenisPenggunaanModelToJson(List<JenisPenggunaanModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JenisPenggunaanModel {
    int? idJenisPenggunaan;
    String? namaJenisPenggunaan;

    JenisPenggunaanModel({
        this.idJenisPenggunaan,
        this.namaJenisPenggunaan,
    });

    factory JenisPenggunaanModel.fromJson(Map<String, dynamic> json) => JenisPenggunaanModel(
        idJenisPenggunaan: json["id_jenis_penggunaan"],
        namaJenisPenggunaan: json["nama_jenis_penggunaan"],
    );

    Map<String, dynamic> toJson() => {
        "id_jenis_penggunaan": idJenisPenggunaan,
        "nama_jenis_penggunaan": namaJenisPenggunaan,
    };
}
