// To parse this JSON data, do
//
//     final monitorKuliahPerkelasModel = monitorKuliahPerkelasModelFromJson(jsonString);

import 'dart:convert';

MonitorKuliahPerkelasModel monitorKuliahPerkelasModelFromJson(String str) => MonitorKuliahPerkelasModel.fromJson(json.decode(str));

String monitorKuliahPerkelasModelToJson(MonitorKuliahPerkelasModel data) => json.encode(data.toJson());

class MonitorKuliahPerkelasModel {
    int code;
    String errorMessage;
    Data data;

    MonitorKuliahPerkelasModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory MonitorKuliahPerkelasModel.fromJson(Map<String, dynamic> json) => MonitorKuliahPerkelasModel(
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
    int idMonitoringPerkuliahan;
    int idKelas;
    String pertemuanKe;
    String tanggal;
    String jamMulai;
    String jamSelesai;
    String materi;
    List<Dosen> dosen;
    int statusSiremun;
    String jamMulaiKuliah;
    String jamSelesaiKuliah;
    String hari;
    String kodeMatakuliah;
    String namaMatakuliah;
    Kehadiran kehadiran;

    ListElement({
        required this.idMonitoringPerkuliahan,
        required this.idKelas,
        required this.pertemuanKe,
        required this.tanggal,
        required this.jamMulai,
        required this.jamSelesai,
        required this.materi,
        required this.dosen,
        required this.statusSiremun,
        required this.jamMulaiKuliah,
        required this.jamSelesaiKuliah,
        required this.hari,
        required this.kodeMatakuliah,
        required this.namaMatakuliah,
        required this.kehadiran,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idMonitoringPerkuliahan: json["id_monitoring_perkuliahan"],
        idKelas: json["id_kelas"],
        pertemuanKe: json["pertemuan_ke"],
        tanggal: json["tanggal"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        materi: json["materi"],
        dosen: List<Dosen>.from(json["dosen"].map((x) => Dosen.fromJson(x))),
        statusSiremun: json["status_siremun"],
        jamMulaiKuliah: json["jam_mulai_kuliah"],
        jamSelesaiKuliah: json["jam_selesai_kuliah"],
        hari: json["hari"],
        kodeMatakuliah: json["kode_matakuliah"],
        namaMatakuliah: json["nama_matakuliah"],
        kehadiran: Kehadiran.fromJson(json["kehadiran"]),
    );

    Map<String, dynamic> toJson() => {
        "id_monitoring_perkuliahan": idMonitoringPerkuliahan,
        "id_kelas": idKelas,
        "pertemuan_ke": pertemuanKe,
        "tanggal": tanggal,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "materi": materi,
        "dosen": List<dynamic>.from(dosen.map((x) => x.toJson())),
        "status_siremun": statusSiremun,
        "jam_mulai_kuliah": jamMulaiKuliah,
        "jam_selesai_kuliah": jamSelesaiKuliah,
        "hari": hari,
        "kode_matakuliah": kodeMatakuliah,
        "nama_matakuliah": namaMatakuliah,
        "kehadiran": kehadiran.toJson(),
    };
}

class Dosen {
    int idPegawai;
    String namaPegawai;
    String gelarDepan;
    String gelarBelakang;
    bool xValue;

    Dosen({
        required this.idPegawai,
        required this.namaPegawai,
        required this.gelarDepan,
        required this.gelarBelakang,
        required this.xValue,
    });

    factory Dosen.fromJson(Map<String, dynamic> json) => Dosen(
        idPegawai: json["id_pegawai"],
        namaPegawai: json["nama_pegawai"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
        xValue: json["x_value"],
    );

    Map<String, dynamic> toJson() => {
        "id_pegawai": idPegawai,
        "nama_pegawai": namaPegawai,
        "gelar_depan": gelarDepan,
        "gelar_belakang": gelarBelakang,
        "x_value": xValue,
    };
}

class Kehadiran {
    int hadir;
    int absen;
    int izin;

    Kehadiran({
        required this.hadir,
        required this.absen,
        required this.izin,
    });

    factory Kehadiran.fromJson(Map<String, dynamic> json) => Kehadiran(
        hadir: json["hadir"],
        absen: json["absen"],
        izin: json["izin"],
    );

    Map<String, dynamic> toJson() => {
        "hadir": hadir,
        "absen": absen,
        "izin": izin,
    };
}
