// To parse this JSON data, do
//
//     final krsMhsDosenModel = krsMhsDosenModelFromJson(jsonString);

import 'dart:convert';

KrsMhsDosenModel krsMhsDosenModelFromJson(String str) => KrsMhsDosenModel.fromJson(json.decode(str));

String krsMhsDosenModelToJson(KrsMhsDosenModel data) => json.encode(data.toJson());

class KrsMhsDosenModel {
    int code;
    String errorMessage;
    Data data;

    KrsMhsDosenModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory KrsMhsDosenModel.fromJson(Map<String, dynamic> json) => KrsMhsDosenModel(
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
    dynamic idMhsPt;
    String namaMahasiswa;
    String noMahasiswa;
    ListProdi prodi;
    KelasProdi kelasProdi;
    String telepon;
    String email;
    String status;
    String statusText;
    String angkatan;
    Krs krs;
    List<Kh> khs;

    ListClass({
        this.idMhsPt,
        required this.namaMahasiswa,
        required this.noMahasiswa,
        required this.prodi,
        required this.kelasProdi,
        required this.telepon,
        required this.email,
        required this.status,
        required this.statusText,
        required this.angkatan,
        required this.krs,
        required this.khs,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        idMhsPt: json["id_mhs_pt"],
        namaMahasiswa: json["nama_mahasiswa"],
        noMahasiswa: json["no_mahasiswa"],
        prodi: ListProdi.fromJson(json["prodi"]),
        kelasProdi: KelasProdi.fromJson(json["kelas_prodi"]),
        telepon: json["telepon"],
        email: json["email"],
        status: json["status"],
        statusText: json["status_text"],
        angkatan: json["angkatan"],
        krs: Krs.fromJson(json["krs"]),
        khs: List<Kh>.from(json["khs"].map((x) => Kh.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_mhs_pt": idMhsPt,
        "nama_mahasiswa": namaMahasiswa,
        "no_mahasiswa": noMahasiswa,
        "prodi": prodi.toJson(),
        "kelas_prodi": kelasProdi.toJson(),
        "telepon": telepon,
        "email": email,
        "status": status,
        "status_text": statusText,
        "angkatan": angkatan,
        "krs": krs.toJson(),
        "khs": List<dynamic>.from(khs.map((x) => x.toJson())),
    };
}

class KelasProdi {
    dynamic idKelasProdi;
    String? namaKelasProdi;

    KelasProdi({
        this.idKelasProdi,
        this.namaKelasProdi,
    });

    factory KelasProdi.fromJson(Map<String, dynamic> json) => KelasProdi(
        idKelasProdi: json["id_kelas_prodi"],
        namaKelasProdi: json["nama_kelas_prodi"],
    );

    Map<String, dynamic> toJson() => {
        "id_kelas_prodi": idKelasProdi,
        "nama_kelas_prodi": namaKelasProdi,
    };
}

class Kh {
    dynamic idSemester;
    String semesterText;
    String ipSemester;
    String sksSemester;
    List<ListMatakuliah> listMatakuliah;

    Kh({
        this.idSemester,
        required this.semesterText,
        required this.ipSemester,
        required this.sksSemester,
        required this.listMatakuliah,
    });

    factory Kh.fromJson(Map<String, dynamic> json) => Kh(
        idSemester: json["id_semester"],
        semesterText: json["semester_text"],
        ipSemester: json["ip_semester"],
        sksSemester: json["sks_semester"],
        listMatakuliah: List<ListMatakuliah>.from(json["list_matakuliah"].map((x) => ListMatakuliah.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_semester": idSemester,
        "semester_text": semesterText,
        "ip_semester": ipSemester,
        "sks_semester": sksSemester,
        "list_matakuliah": List<dynamic>.from(listMatakuliah.map((x) => x.toJson())),
    };
}

class ListMatakuliah {
    dynamic idMatakuliah;
    String namaMatakuliah;
    String sksTotal;
    String nilai;
    String status;

    ListMatakuliah({
        this.idMatakuliah,
        required this.namaMatakuliah,
        required this.sksTotal,
        required this.nilai,
        required this.status,
    });

    factory ListMatakuliah.fromJson(Map<String, dynamic> json) => ListMatakuliah(
        idMatakuliah: json["id_matakuliah"],
        namaMatakuliah: json["nama_matakuliah"],
        sksTotal: json["sks_total"],
        nilai: json["nilai"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id_matakuliah": idMatakuliah,
        "nama_matakuliah": namaMatakuliah,
        "sks_total": sksTotal,
        "nilai": nilai,
        "status": status,
    };
}


class Krs {
    String awalKrs;
    String akhirKrs;
    String awalKprs;
    String akhirKprs;
    dynamic maxSks;
    String tanggal;
    String statusKrs;
    String statusKrsText;
    List<ListKr> listKrs;

    Krs({
        required this.awalKrs,
        required this.akhirKrs,
        required this.awalKprs,
        required this.akhirKprs,
        this.maxSks,
        required this.tanggal,
        required this.statusKrs,
        required this.statusKrsText,
        required this.listKrs,
    });

    factory Krs.fromJson(Map<String, dynamic> json) => Krs(
        awalKrs: json["awal_krs"],
        akhirKrs: json["akhir_krs"],
        awalKprs: json["awal_kprs"],
        akhirKprs: json["akhir_kprs"],
        maxSks: json["max_sks"],
        tanggal: json["tanggal"],
        statusKrs: json["status_krs"],
        statusKrsText: json["status_krs_text"],
        listKrs: List<ListKr>.from(json["list_krs"].map((x) => ListKr.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "awal_krs": awalKrs,
        "akhir_krs": akhirKrs,
        "awal_kprs": awalKprs,
        "akhir_kprs": akhirKprs,
        "max_sks": maxSks,
        "tanggal": tanggal,
        "status_krs": statusKrs,
        "status_krs_text": statusKrsText,
        "list_krs": List<dynamic>.from(listKrs.map((x) => x.toJson())),
    };
}

class ListKr {
    dynamic idKrs;
    String status;
    Kelas kelas;
    Matakuliah matakuliah;
    ListKrProdi prodi;
    KelasProdi kelasProdi;

    ListKr({
        this.idKrs,
        required this.status,
        required this.kelas,
        required this.matakuliah,
        required this.prodi,
        required this.kelasProdi,
    });

    factory ListKr.fromJson(Map<String, dynamic> json) => ListKr(
        idKrs: json["id_krs"],
        status: json["status"],
        kelas: Kelas.fromJson(json["kelas"]),
        matakuliah: Matakuliah.fromJson(json["matakuliah"]),
        prodi: ListKrProdi.fromJson(json["prodi"]),
        kelasProdi: KelasProdi.fromJson(json["kelas_prodi"]),
    );

    Map<String, dynamic> toJson() => {
        "id_krs": idKrs,
        "status": status,
        "kelas": kelas.toJson(),
        "matakuliah": matakuliah.toJson(),
        "prodi": prodi.toJson(),
        "kelas_prodi": kelasProdi.toJson(),
    };
}

class Kelas {
    dynamic idKelas;
    String? kodeKelas;
    String? semester;

    Kelas({
        this.idKelas,
        this.kodeKelas,
        this.semester,
    });

    factory Kelas.fromJson(Map<String, dynamic> json) => Kelas(
        idKelas: json["id_kelas"],
        kodeKelas: json["kode_kelas"],
        semester: json["semester"],
    );

    Map<String, dynamic> toJson() => {
        "id_kelas": idKelas,
        "kode_kelas": kodeKelas,
        "semester": semester,
    };
}

class Matakuliah {
    dynamic idMatakuliah;
    String kodeMatakuliah;
    String namaMatakuliah;
    String sksTotal;

    Matakuliah({
        this.idMatakuliah,
        required this.kodeMatakuliah,
        required this.namaMatakuliah,
        required this.sksTotal,
    });

    factory Matakuliah.fromJson(Map<String, dynamic> json) => Matakuliah(
        idMatakuliah: json["id_matakuliah"],
        kodeMatakuliah: json["kode_matakuliah"],
        namaMatakuliah: json["nama_matakuliah"],
        sksTotal: json["sks_total"],
    );

    Map<String, dynamic> toJson() => {
        "id_matakuliah": idMatakuliah,
        "kode_matakuliah": kodeMatakuliah,
        "nama_matakuliah": namaMatakuliah,
        "sks_total": sksTotal,
    };
}

class ListKrProdi {
    dynamic idProdi;
    String? namaProdi;

    ListKrProdi({
        this.idProdi,
        this.namaProdi,
    });

    factory ListKrProdi.fromJson(Map<String, dynamic> json) => ListKrProdi(
        idProdi: json["id_prodi"],
        namaProdi: json["nama_prodi"],
    );

    Map<String, dynamic> toJson() => {
        "id_prodi": idProdi,
        "nama_prodi": namaProdi,
    };
}

class ListProdi {
    dynamic idProdi;
    String namaProdi;

    ListProdi({
        this.idProdi,
        required this.namaProdi,
    });

    factory ListProdi.fromJson(Map<String, dynamic> json) => ListProdi(
        idProdi: json["id_prodi"],
        namaProdi: json["nama_prodi"],
    );

    Map<String, dynamic> toJson() => {
        "id_prodi": idProdi,
        "nama_prodi": namaProdi,
    };
}


