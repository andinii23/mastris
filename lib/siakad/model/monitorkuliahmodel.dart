// To parse this JSON data, do
//
//     final monitoringKuliahModel = monitoringKuliahModelFromJson(jsonString);

import 'dart:convert';

MonitoringKuliahModel monitoringKuliahModelFromJson(String str) => MonitoringKuliahModel.fromJson(json.decode(str));

String monitoringKuliahModelToJson(MonitoringKuliahModel data) => json.encode(data.toJson());

class MonitoringKuliahModel {
    MonitoringKuliahModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    int code;
    String errorMessage;
    Data data;

    factory MonitoringKuliahModel.fromJson(Map<String, dynamic> json) => MonitoringKuliahModel(
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
    Data({
        required this.total,
        required this.perPage,
        required this.page,
        required this.list,
    });

    int total;
    int perPage;
    int page;
    ListClass list;

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
    ListClass({
        required this.idSemester,
        required this.listKelas,
    });

    String idSemester;
    List<ListKelas> listKelas;

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        idSemester: json["id_semester"],
        listKelas: List<ListKelas>.from(json["list_kelas"].map((x) => ListKelas.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_semester": idSemester,
        "list_kelas": List<dynamic>.from(listKelas.map((x) => x.toJson())),
    };
}

class ListKelas {
    ListKelas({
        required this.idKelas,
        required this.kodeKelas,
        this.jamMulai,
        this.jamSelesai,
        this.hari,
        required this.idSemester,
        required this.jumlahMahasiswa,
        required this.ruangKuliah,
        required this.kelasProdi,
        required this.matakuliah,
        required this.prodi,
        required this.dosen,
    });

    int idKelas;
    String kodeKelas;
    String? jamMulai;
    String? jamSelesai;
    String? hari;
    int idSemester;
    int jumlahMahasiswa;
    RuangKuliah ruangKuliah;
    KelasProdi kelasProdi;
    Matakuliah matakuliah;
    Prodi prodi;
    List<Dosen> dosen;

    factory ListKelas.fromJson(Map<String, dynamic> json) => ListKelas(
        idKelas: json["id_kelas"],
        kodeKelas: json["kode_kelas"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        hari: json["hari"],
        idSemester: json["id_semester"],
        jumlahMahasiswa: json["jumlah_mahasiswa"],
        ruangKuliah: RuangKuliah.fromJson(json["ruang_kuliah"]),
        kelasProdi: KelasProdi.fromJson(json["kelas_prodi"]),
        matakuliah: Matakuliah.fromJson(json["matakuliah"]),
        prodi: Prodi.fromJson(json["prodi"]),
        dosen: List<Dosen>.from(json["dosen"].map((x) => Dosen.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_kelas": idKelas,
        "kode_kelas": kodeKelas,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "hari": hari,
        "id_semester": idSemester,
        "jumlah_mahasiswa": jumlahMahasiswa,
        "ruang_kuliah": ruangKuliah.toJson(),
        "kelas_prodi": kelasProdi.toJson(),
        "matakuliah": matakuliah.toJson(),
        "prodi": prodi.toJson(),
        "dosen": List<dynamic>.from(dosen.map((x) => x.toJson())),
    };
}

class RuangKuliah {
    RuangKuliah({
       this.namaRuang,
    });

    dynamic namaRuang;

    factory RuangKuliah.fromJson(Map<String, dynamic> json) => RuangKuliah(
        namaRuang: json["nama_ruang"],
    );

    Map<String, dynamic> toJson() => {
        "nama_ruang": namaRuang,
    };
}

class KelasProdi {
    KelasProdi({
       this.namaKelasProdi,
    });

    dynamic namaKelasProdi;

    factory KelasProdi.fromJson(Map<String, dynamic> json) => KelasProdi(
        namaKelasProdi: json["nama_kelas_prodi"],
    );

    Map<String, dynamic> toJson() => {
        "nama_kelas_prodi": namaKelasProdi,
    };
}

class Matakuliah {
    Matakuliah({
        required this.idMatakuliah,
        required this.namaMatakuliah,
        required this.kodeMatakuliah,
        this.uploadNilai,
        required this.sksTotal,
    });

    int idMatakuliah;
    String namaMatakuliah;
    String kodeMatakuliah;
    dynamic uploadNilai;
    String sksTotal;

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
    Prodi({
        required this.namaProdi,
        required this.strata,
    });

    String namaProdi;
    String strata;

    factory Prodi.fromJson(Map<String, dynamic> json) => Prodi(
        namaProdi: json["nama_prodi"],
        strata: json["strata"],
    );

    Map<String, dynamic> toJson() => {
        "nama_prodi": namaProdi,
        "strata": strata,
    };
}

class Dosen {
    Dosen({
        required this.idDosen,
        required this.namaPegawai,
        this.gelarDepan,
        required this.gelarBelakang,
    });

    int idDosen;
    String namaPegawai;
    dynamic gelarDepan;
    String gelarBelakang;

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


