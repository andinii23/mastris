// To parse this JSON data, do
//
//     final krsInboundModel = krsInboundModelFromJson(jsonString);

import 'dart:convert';

KrsInboundModel krsInboundModelFromJson(String str) => KrsInboundModel.fromJson(json.decode(str));

String krsInboundModelToJson(KrsInboundModel data) => json.encode(data.toJson());

class KrsInboundModel {
    int code;
    String errorMessage;
    Data data;

    KrsInboundModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory KrsInboundModel.fromJson(Map<String, dynamic> json) => KrsInboundModel(
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
    int idKelas;
    String kodeKelas;
    String semester;
    String? jamMulai;
    String? jamSelesai;
    String hari;
    int idSemester;
    int kapasitas;
    KelasProdi kelasProdi;
    RuangKuliah ruangKuliah;
    Matakuliah matakuliah;
    Prodi prodi;
    bool bisaDikontrak;
    List<Dosen> dosen;

    ListElement({
        required this.idKelas,
        required this.kodeKelas,
        required this.semester,
        this.jamMulai,
        this.jamSelesai,
        required this.hari,
        required this.idSemester,
        required this.kapasitas,
        required this.kelasProdi,
        required this.ruangKuliah,
        required this.matakuliah,
        required this.prodi,
        required this.bisaDikontrak,
        required this.dosen,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idKelas: json["id_kelas"],
        kodeKelas: json["kode_kelas"],
        semester: json["semester"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        hari: json["hari"],
        idSemester: json["id_semester"],
        kapasitas: json["kapasitas"],
        kelasProdi: KelasProdi.fromJson(json["kelas_prodi"]),
        ruangKuliah: RuangKuliah.fromJson(json["ruang_kuliah"]),
        matakuliah: Matakuliah.fromJson(json["matakuliah"]),
        prodi: Prodi.fromJson(json["prodi"]),
        bisaDikontrak: json["bisa_dikontrak"],
        dosen: List<Dosen>.from(json["dosen"].map((x) => Dosen.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_kelas": idKelas,
        "kode_kelas": kodeKelas,
        "semester": semester,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "hari": hari,
        "id_semester": idSemester,
        "kapasitas": kapasitas,
        "kelas_prodi": kelasProdi.toJson(),
        "ruang_kuliah": ruangKuliah.toJson(),
        "matakuliah": matakuliah.toJson(),
        "prodi": prodi.toJson(),
        "bisa_dikontrak": bisaDikontrak,
        "dosen": List<dynamic>.from(dosen.map((x) => x.toJson())),
    };
}

class Dosen {
    int idDosen;
    String namaDosen;
    String? gelarDepan;
    String gelarBelakang;

    Dosen({
        required this.idDosen,
        required this.namaDosen,
        this.gelarDepan,
        required this.gelarBelakang,
    });

    factory Dosen.fromJson(Map<String, dynamic> json) => Dosen(
        idDosen: json["id_dosen"],
        namaDosen: json["nama_dosen"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
    );

    Map<String, dynamic> toJson() => {
        "id_dosen": idDosen,
        "nama_dosen": namaDosen,
        "gelar_depan": gelarDepan,
        "gelar_belakang": gelarBelakang,
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
    String? namaRuangKuliah;

    RuangKuliah({
        this.namaRuangKuliah,
    });

    factory RuangKuliah.fromJson(Map<String, dynamic> json) => RuangKuliah(
        namaRuangKuliah: json["nama_ruang_kuliah"],
    );

    Map<String, dynamic> toJson() => {
        "nama_ruang_kuliah": namaRuangKuliah,
    };
}


