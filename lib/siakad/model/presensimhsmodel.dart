// To parse this JSON data, do
//
//     final presensiModel = presensiModelFromJson(jsonString);

import 'dart:convert';

PresensiModel presensiModelFromJson(String str) => PresensiModel.fromJson(json.decode(str));

String presensiModelToJson(PresensiModel data) => json.encode(data.toJson());

class PresensiModel {
    int code;
    String errorMessage;
    Data data;

    PresensiModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory PresensiModel.fromJson(Map<String, dynamic> json) => PresensiModel(
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
    int? idKelas;
    String? kodeKelas;
    int jumlahPertemuan;
    String hari;
    String? jamMulai;
    String? jamSelesai;
    RuangKuliah ruangKuliah;
    Matakuliah matakuliah;
    List<Dosen> dosen;
    int jumlahMasuk;
    int jumlahIzin;
    int jumlahAbsen;

    ListElement({
        this.idKelas,
        this.kodeKelas,
        required this.jumlahPertemuan,
        required this.hari,
        this.jamMulai,
        this.jamSelesai,
        required this.ruangKuliah,
        required this.matakuliah,
        required this.dosen,
        required this.jumlahMasuk,
        required this.jumlahIzin,
        required this.jumlahAbsen,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idKelas: json["id_kelas"],
        kodeKelas: json["kode_kelas"],
        jumlahPertemuan: json["jumlah_pertemuan"],
        hari: json["hari"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        ruangKuliah: RuangKuliah.fromJson(json["ruang_kuliah"]),
        matakuliah: Matakuliah.fromJson(json["matakuliah"]),
        dosen: List<Dosen>.from(json["dosen"].map((x) => Dosen.fromJson(x))),
        jumlahMasuk: json["jumlah_masuk"],
        jumlahIzin: json["jumlah_izin"],
        jumlahAbsen: json["jumlah_absen"],
    );

    Map<String, dynamic> toJson() => {
        "id_kelas": idKelas,
        "kode_kelas": kodeKelas,
        "jumlah_pertemuan": jumlahPertemuan,
        "hari": hari,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "ruang_kuliah": ruangKuliah.toJson(),
        "matakuliah": matakuliah.toJson(),
        "dosen": List<dynamic>.from(dosen.map((x) => x.toJson())),
        "jumlah_masuk": jumlahMasuk,
        "jumlah_izin": jumlahIzin,
        "jumlah_absen": jumlahAbsen,
    };
}

class Dosen {
    int idDosen;
    String namaPegawai;
    dynamic gelarDepan;
    String gelarBelakang;

    Dosen({
        required this.idDosen,
        required this.namaPegawai,
        this.gelarDepan,
        required this.gelarBelakang,
    });

    factory Dosen.fromJson(Map<String, dynamic> json) => Dosen(
        idDosen: json["id_dosen"],
        namaPegawai: json["nama_pegawai"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
    );

    Map<String, dynamic> toJson() => {
        "id_dosen": idDosen,
        "nama_pegawai": namaPegawai,
        "gelar_depan": gelarDepan,
        "gelar_belakang": gelarBelakang,
    };
}

class Matakuliah {
    int idMatakuliah;
    String namaMatakuliah;
    String kodeMatakuliah;
    dynamic uploadNilai;
    String sksTotal;

    Matakuliah({
        required this.idMatakuliah,
        required this.namaMatakuliah,
        required this.kodeMatakuliah,
        this.uploadNilai,
        required this.sksTotal,
    });

    factory Matakuliah.fromJson(Map<String, dynamic> json) => Matakuliah(
        idMatakuliah: json["id_matakuliah"],
        namaMatakuliah: json["nama_matakuliah"],
        kodeMatakuliah: json["kode_matakuliah"],
        uploadNilai: json["upload_nilai"],
        sksTotal: json["sks_total"],
    );

    Map<String, dynamic> toJson() => {
        "id_matakuliah": idMatakuliah,
        "nama_matakuliah": namaMatakuliah,
        "kode_matakuliah": kodeMatakuliah,
        "upload_nilai": uploadNilai,
        "sks_total": sksTotal,
    };
}

class RuangKuliah {
    String? namaRuang;

    RuangKuliah({
        this.namaRuang,
    });

    factory RuangKuliah.fromJson(Map<String, dynamic> json) => RuangKuliah(
        namaRuang: json["nama_ruang"],
    );

    Map<String, dynamic> toJson() => {
        "nama_ruang": namaRuang,
    };
}
