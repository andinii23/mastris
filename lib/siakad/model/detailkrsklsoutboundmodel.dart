// To parse this JSON data, do
//
//     final detailKrsKelasOutboundModel = detailKrsKelasOutboundModelFromJson(jsonString);

import 'dart:convert';

DetailKrsKelasOutboundModel detailKrsKelasOutboundModelFromJson(String str) => DetailKrsKelasOutboundModel.fromJson(json.decode(str));

String detailKrsKelasOutboundModelToJson(DetailKrsKelasOutboundModel data) => json.encode(data.toJson());

class DetailKrsKelasOutboundModel {
    int code;
    String errorMessage;
    Data data;

    DetailKrsKelasOutboundModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory DetailKrsKelasOutboundModel.fromJson(Map<String, dynamic> json) => DetailKrsKelasOutboundModel(
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
    MatakuliahAsal matakuliahAsal;
    MatakuliahKonversi matakuliahKonversi;
    int syaratIpk;
    int syaratSemester;
    int syaratSks;
    int kesimpulan;

    ListClass({
        required this.matakuliahAsal,
        required this.matakuliahKonversi,
        required this.syaratIpk,
        required this.syaratSemester,
        required this.syaratSks,
        required this.kesimpulan,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        matakuliahAsal: MatakuliahAsal.fromJson(json["matakuliah_asal"]),
        matakuliahKonversi: MatakuliahKonversi.fromJson(json["matakuliah_konversi"]),
        syaratIpk: json["syarat_ipk"],
        syaratSemester: json["syarat_semester"],
        syaratSks: json["syarat_sks"],
        kesimpulan: json["kesimpulan"],
    );

    Map<String, dynamic> toJson() => {
        "matakuliah_asal": matakuliahAsal.toJson(),
        "matakuliah_konversi": matakuliahKonversi.toJson(),
        "syarat_ipk": syaratIpk,
        "syarat_semester": syaratSemester,
        "syarat_sks": syaratSks,
        "kesimpulan": kesimpulan,
    };
}

class MatakuliahAsal {
    int idMatakuliah;
    String kodeMatakuliah;
    String namaMatakuliah;
    int sksTotal;
    String prodi;
    String pt;
    String jenjangPendidikan;

    MatakuliahAsal({
        required this.idMatakuliah,
        required this.kodeMatakuliah,
        required this.namaMatakuliah,
        required this.sksTotal,
        required this.prodi,
        required this.pt,
        required this.jenjangPendidikan,
    });

    factory MatakuliahAsal.fromJson(Map<String, dynamic> json) => MatakuliahAsal(
        idMatakuliah: json["id_matakuliah"],
        kodeMatakuliah: json["kode_matakuliah"],
        namaMatakuliah: json["nama_matakuliah"],
        sksTotal: json["sks_total"],
        prodi: json["prodi"],
        pt: json["pt"],
        jenjangPendidikan: json["jenjang_pendidikan"],
    );

    Map<String, dynamic> toJson() => {
        "id_matakuliah": idMatakuliah,
        "kode_matakuliah": kodeMatakuliah,
        "nama_matakuliah": namaMatakuliah,
        "sks_total": sksTotal,
        "prodi": prodi,
        "pt": pt,
        "jenjang_pendidikan": jenjangPendidikan,
    };
}

class MatakuliahKonversi {
    int idMatakuliah;
    String kodeMatakuliah;
    String namaMatakuliah;
    String sksTotal;
    String namaProdi;
    String prodi;
    String pt;
    String jenjangPendidikan;

    MatakuliahKonversi({
        required this.idMatakuliah,
        required this.kodeMatakuliah,
        required this.namaMatakuliah,
        required this.sksTotal,
        required this.namaProdi,
        required this.prodi,
        required this.pt,
        required this.jenjangPendidikan,
    });

    factory MatakuliahKonversi.fromJson(Map<String, dynamic> json) => MatakuliahKonversi(
        idMatakuliah: json["id_matakuliah"],
        kodeMatakuliah: json["kode_matakuliah"],
        namaMatakuliah: json["nama_matakuliah"],
        sksTotal: json["sks_total"],
        namaProdi: json["nama_prodi"],
        prodi: json["prodi"],
        pt: json["pt"],
        jenjangPendidikan: json["jenjang_pendidikan"],
    );

    Map<String, dynamic> toJson() => {
        "id_matakuliah": idMatakuliah,
        "kode_matakuliah": kodeMatakuliah,
        "nama_matakuliah": namaMatakuliah,
        "sks_total": sksTotal,
        "nama_prodi": namaProdi,
        "prodi": prodi,
        "pt": pt,
        "jenjang_pendidikan": jenjangPendidikan,
    };
}
