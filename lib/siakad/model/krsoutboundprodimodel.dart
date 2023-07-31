// To parse this JSON data, do
//
//     final krsOutboundProdiModel = krsOutboundProdiModelFromJson(jsonString);

import 'dart:convert';

KrsOutboundProdiModel krsOutboundProdiModelFromJson(String str) => KrsOutboundProdiModel.fromJson(json.decode(str));

String krsOutboundProdiModelToJson(KrsOutboundProdiModel data) => json.encode(data.toJson());

class KrsOutboundProdiModel {
    String idProdi;
    String kodeProdi;
    String namaProdi;
    int idJenjangPendidikan;
    String namaJenjangPendidikan;

    KrsOutboundProdiModel({
        required this.idProdi,
        required this.kodeProdi,
        required this.namaProdi,
        required this.idJenjangPendidikan,
        required this.namaJenjangPendidikan,
    });

    factory KrsOutboundProdiModel.fromJson(Map<String, dynamic> json) => KrsOutboundProdiModel(
        idProdi: json["id_prodi"],
        kodeProdi: json["kode_prodi"],
        namaProdi: json["nama_prodi"],
        idJenjangPendidikan: json["id_jenjang_pendidikan"],
        namaJenjangPendidikan: json["nama_jenjang_pendidikan"],
    );

    Map<String, dynamic> toJson() => {
        "id_prodi": idProdi,
        "kode_prodi": kodeProdi,
        "nama_prodi": namaProdi,
        "id_jenjang_pendidikan": idJenjangPendidikan,
        "nama_jenjang_pendidikan": namaJenjangPendidikan,
    };
    @override

    String toString() => namaProdi;
}
