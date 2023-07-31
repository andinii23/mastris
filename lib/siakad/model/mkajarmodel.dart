// To parse this JSON data, do
//
//     final mkAjarModel = mkAjarModelFromJson(jsonString);

import 'dart:convert';

MkAjarModel mkAjarModelFromJson(String str) => MkAjarModel.fromJson(json.decode(str));

String mkAjarModelToJson(MkAjarModel data) => json.encode(data.toJson());

class MkAjarModel {
    int code;
    String errorMessage;
    Data data;

    MkAjarModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory MkAjarModel.fromJson(Map<String, dynamic> json) => MkAjarModel(
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
    int idSemester;
    String semesterText;
    int jumlahKelas;
    List<ListKela> listKelas;

    ListElement({
        required this.idSemester,
        required this.semesterText,
        required this.jumlahKelas,
        required this.listKelas,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idSemester: json["id_semester"],
        semesterText: json["semester_text"],
        jumlahKelas: json["jumlah_kelas"],
        listKelas: List<ListKela>.from(json["list_kelas"].map((x) => ListKela.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_semester": idSemester,
        "semester_text": semesterText,
        "jumlah_kelas": jumlahKelas,
        "list_kelas": List<dynamic>.from(listKelas.map((x) => x.toJson())),
    };
}

class ListKela {
    int idKelas;
    String kodeKelas;
    String? jamMulai;
    String? jamSelesai;
    String hari;
    int idSemester;
    int jumlahMahasiswa;
    KelasProdi kelasProdi;
    RuangKuliah ruangKuliah;
    Matakuliah matakuliah;
    Prodi prodi;

    ListKela({
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
    });

    factory ListKela.fromJson(Map<String, dynamic> json) => ListKela(
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
    };
}

class KelasProdi {
    dynamic namaKelasProdi;

    KelasProdi({
        this.namaKelasProdi,
    });

    factory KelasProdi.fromJson(Map<String, dynamic> json) => KelasProdi(
        namaKelasProdi: json["nama_kelas_prodi"],
    );

    Map<String, dynamic> toJson() => {
        "nama_kelas_prodi": namaKelasProdi,
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


