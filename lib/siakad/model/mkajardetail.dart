// To parse this JSON data, do
//
//     final mkAjarDetailModel = mkAjarDetailModelFromJson(jsonString);

import 'dart:convert';

MkAjarDetailModel mkAjarDetailModelFromJson(String str) => MkAjarDetailModel.fromJson(json.decode(str));

String mkAjarDetailModelToJson(MkAjarDetailModel data) => json.encode(data.toJson());

class MkAjarDetailModel {
    int code;
    String errorMessage;
    Data data;

    MkAjarDetailModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory MkAjarDetailModel.fromJson(Map<String, dynamic> json) => MkAjarDetailModel(
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
    int idKelas;
    String kodeKelas;
    dynamic jamMulai;
    dynamic jamSelesai;
    String hari;
    int idSemester;
    int jumlahMahasiswa;
    KelasProdi kelasProdi;
    RuangKuliah ruangKuliah;
    Matakuliah matakuliah;
    Prodi prodi;
    List<Mahasiswa> mahasiswa;

    ListClass({
        required this.idKelas,
        required this.kodeKelas,
        this.jamMulai,
        this.jamSelesai,
        required this.hari,
        required this.idSemester,
        required this.jumlahMahasiswa,
        required this.kelasProdi,
        required this.ruangKuliah,
        required this.matakuliah,
        required this.prodi,
        required this.mahasiswa,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        idKelas: json["id_kelas"],
        kodeKelas: json["kode_kelas"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        hari: json["hari"],
        idSemester: json["id_semester"],
        jumlahMahasiswa: json["jumlah_mahasiswa"],
        kelasProdi: KelasProdi.fromJson(json["kelas_prodi"]),
        ruangKuliah: RuangKuliah.fromJson(json["ruang_kuliah"]),
        matakuliah: Matakuliah.fromJson(json["matakuliah"]),
        prodi: Prodi.fromJson(json["prodi"]),
        mahasiswa: List<Mahasiswa>.from(json["mahasiswa"].map((x) => Mahasiswa.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_kelas": idKelas,
        "kode_kelas": kodeKelas,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "hari": hari,
        "id_semester": idSemester,
        "jumlah_mahasiswa": jumlahMahasiswa,
        "kelas_prodi": kelasProdi.toJson(),
        "ruang_kuliah": ruangKuliah.toJson(),
        "matakuliah": matakuliah.toJson(),
        "prodi": prodi.toJson(),
        "mahasiswa": List<dynamic>.from(mahasiswa.map((x) => x.toJson())),
    };
}

class KelasProdi {
    String namaKelasProdi;

    KelasProdi({
        required this.namaKelasProdi,
    });

    factory KelasProdi.fromJson(Map<String, dynamic> json) => KelasProdi(
        namaKelasProdi: json["nama_kelas_prodi"],
    );

    Map<String, dynamic> toJson() => {
        "nama_kelas_prodi": namaKelasProdi,
    };
}

class Mahasiswa {
    int idMhsPt;
    dynamic nilai;
    String noMhs;
    String angkatan;
    String namaMahasiswa;
    String idProdi;
    String namaProdi;

    Mahasiswa({
        required this.idMhsPt,
        this.nilai,
        required this.noMhs,
        required this.angkatan,
        required this.namaMahasiswa,
        required this.idProdi,
        required this.namaProdi,
    });

    factory Mahasiswa.fromJson(Map<String, dynamic> json) => Mahasiswa(
        idMhsPt: json["id_mhs_pt"],
        nilai: json["nilai"],
        noMhs: json["no_mhs"],
        angkatan: json["angkatan"],
        namaMahasiswa: json["nama_mahasiswa"],
        idProdi: json["id_prodi"],
        namaProdi: json["nama_prodi"],
    );

    Map<String, dynamic> toJson() => {
        "id_mhs_pt": idMhsPt,
        "nilai": nilai,
        "no_mhs": noMhs,
        "angkatan": angkatan,
        "nama_mahasiswa": namaMahasiswa,
        "id_prodi": idProdi,
        "nama_prodi": namaProdi,
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

class Prodi {
    String namaProdi;
    String strata;

    Prodi({
        required this.namaProdi,
        required this.strata,
    });

    factory Prodi.fromJson(Map<String, dynamic> json) => Prodi(
        namaProdi: json["nama_prodi"],
        strata: json["strata"],
    );

    Map<String, dynamic> toJson() => {
        "nama_prodi": namaProdi,
        "strata": strata,
    };
}

class RuangKuliah {
    dynamic namaRuang;

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

