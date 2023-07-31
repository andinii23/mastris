// To parse this JSON data, do
//
//     final krsOutboundModel = krsOutboundModelFromJson(jsonString);

import 'dart:convert';

KrsOutboundModel krsOutboundModelFromJson(String str) =>
    KrsOutboundModel.fromJson(json.decode(str));

String krsOutboundModelToJson(KrsOutboundModel data) =>
    json.encode(data.toJson());

class KrsOutboundModel {
  dynamic uuidPtAsal;
  dynamic kodePt;
  dynamic namaPt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic singkatan;
  dynamic npsn;
  dynamic status;

  KrsOutboundModel({
    this.uuidPtAsal,
    this.kodePt,
    this.namaPt,
    this.createdAt,
    this.updatedAt,
    this.singkatan,
    this.npsn,
    this.status,
  });

  factory KrsOutboundModel.fromJson(Map<String, dynamic> json) =>
      KrsOutboundModel(
        uuidPtAsal: json["uuid_pt_asal"],
        kodePt: json["kode_pt"],
        namaPt: json["nama_pt"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        singkatan: json["singkatan"],
        npsn: json["npsn"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "uuid_pt_asal": uuidPtAsal,
        "kode_pt": kodePt,
        "nama_pt": namaPt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "singkatan": singkatan,
        "npsn": npsn,
        "status": status,
      };

  @override
  String toString() => namaPt;
}
