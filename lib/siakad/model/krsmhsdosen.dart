// To parse this JSON data, do
//
//     final krsMhsDosenModel = krsMhsDosenModelFromJson(jsonString);

import 'dart:convert';

KrsMhsDosenModel krsMhsDosenModelFromJson(String str) => KrsMhsDosenModel.fromJson(json.decode(str));

String krsMhsDosenModelToJson(KrsMhsDosenModel data) => json.encode(data.toJson());

class KrsMhsDosenModel {
    int? code;
    String? errorMessage;
    Data? data;

    KrsMhsDosenModel({
        this.code,
        this.errorMessage,
        this.data,
    });

    factory KrsMhsDosenModel.fromJson(Map<String, dynamic> json) => KrsMhsDosenModel(
        code: json["code"],
        errorMessage: json["error_message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "error_message": errorMessage,
        "data": data?.toJson(),
    };
}

class Data {
    int? total;
    int? perPage;
    int? page;
    ListClass? list;

    Data({
        this.total,
        this.perPage,
        this.page,
        this.list,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        perPage: json["per_page"],
        page: json["page"],
        list: json["list"] == null ? null : ListClass.fromJson(json["list"]),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "per_page": perPage,
        "page": page,
        "list": list?.toJson(),
    };
}

class ListClass {
    int? idMhsPt;
    String? namaMahasiswa;
    String? noMahasiswa;
    ListProdi? prodi;
    ListKelasProdi? kelasProdi;
    String? telepon;
    String? email;
    String? status;
    String? statusText;
    String? angkatan;
    Krs? krs;
    List<Kh>? khs;

    ListClass({
        this.idMhsPt,
        this.namaMahasiswa,
        this.noMahasiswa,
        this.prodi,
        this.kelasProdi,
        this.telepon,
        this.email,
        this.status,
        this.statusText,
        this.angkatan,
        this.krs,
        this.khs,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        idMhsPt: json["id_mhs_pt"],
        namaMahasiswa: json["nama_mahasiswa"],
        noMahasiswa: json["no_mahasiswa"],
        prodi: json["prodi"] == null ? null : ListProdi.fromJson(json["prodi"]),
        kelasProdi: json["kelas_prodi"] == null ? null : ListKelasProdi.fromJson(json["kelas_prodi"]),
        telepon: json["telepon"],
        email: json["email"],
        status: json["status"],
        statusText: json["status_text"],
        angkatan: json["angkatan"],
        krs: json["krs"] == null ? null : Krs.fromJson(json["krs"]),
        khs: json["khs"] == null ? [] : List<Kh>.from(json["khs"]!.map((x) => Kh.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_mhs_pt": idMhsPt,
        "nama_mahasiswa": namaMahasiswa,
        "no_mahasiswa": noMahasiswa,
        "prodi": prodi?.toJson(),
        "kelas_prodi": kelasProdi?.toJson(),
        "telepon": telepon,
        "email": email,
        "status": status,
        "status_text": statusText,
        "angkatan": angkatan,
        "krs": krs?.toJson(),
        "khs": khs == null ? [] : List<dynamic>.from(khs!.map((x) => x.toJson())),
    };
}

class ListKelasProdi {
    int? idKelasProdi;
    String? namaKelasProdi;

    ListKelasProdi({
        this.idKelasProdi,
        this.namaKelasProdi,
    });

    factory ListKelasProdi.fromJson(Map<String, dynamic> json) => ListKelasProdi(
        idKelasProdi: json["id_kelas_prodi"],
        namaKelasProdi: json["nama_kelas_prodi"],
    );

    Map<String, dynamic> toJson() => {
        "id_kelas_prodi": idKelasProdi,
        "nama_kelas_prodi": namaKelasProdi,
    };
}

class Kh {
    String? idSemester;
    String? semesterText;
    String? ipSemester;
    String? sksSemester;
    List<ListMatakuliah>? listMatakuliah;

    Kh({
        this.idSemester,
        this.semesterText,
        this.ipSemester,
        this.sksSemester,
        this.listMatakuliah,
    });

    factory Kh.fromJson(Map<String, dynamic> json) => Kh(
        idSemester: json["id_semester"],
        semesterText: json["semester_text"],
        ipSemester: json["ip_semester"],
        sksSemester: json["sks_semester"],
        listMatakuliah: json["list_matakuliah"] == null ? [] : List<ListMatakuliah>.from(json["list_matakuliah"]!.map((x) => ListMatakuliah.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_semester": idSemester,
        "semester_text": semesterText,
        "ip_semester": ipSemester,
        "sks_semester": sksSemester,
        "list_matakuliah": listMatakuliah == null ? [] : List<dynamic>.from(listMatakuliah!.map((x) => x.toJson())),
    };
}

class ListMatakuliah {
    int? idMatakuliah;
    String? namaMatakuliah;
    String? sksTotal;
    String? nilai;
    String? status;

    ListMatakuliah({
        this.idMatakuliah,
        this.namaMatakuliah,
        this.sksTotal,
        this.nilai,
        this.status,
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
    String? awalKrs;
    String? akhirKrs;
    String? awalKprs;
    dynamic akhirKprs;
    int? maxSks;
    String? tanggal;
    String? statusKrs;
    String? statusKrsText;
    List<ListKr>? listKrs;

    Krs({
        this.awalKrs,
        this.akhirKrs,
        this.awalKprs,
        this.akhirKprs,
        this.maxSks,
        this.tanggal,
        this.statusKrs,
        this.statusKrsText,
        this.listKrs,
    });

    factory Krs.fromJson(Map<String, dynamic> json) => Krs(
        awalKrs: json["awal_krs"],
        akhirKrs: json["akhir_krs"],
        awalKprs: json["awal_kprs"],
        akhirKprs: json["akhir_kprs"] == "" ? "" : DateTime.parse(json["akhir_kprs"]),
        maxSks: json["max_sks"],
        tanggal: json["tanggal"],
        statusKrs: json["status_krs"],
        statusKrsText: json["status_krs_text"],
        listKrs: json["list_krs"] == null ? [] : List<ListKr>.from(json["list_krs"]!.map((x) => ListKr.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "awal_krs": awalKrs,
        "akhir_krs": akhirKrs,
        "awal_kprs": awalKprs,
        "akhir_kprs": "${akhirKprs!.year.toString().padLeft(4, '0')}-${akhirKprs!.month.toString().padLeft(2, '0')}-${akhirKprs!.day.toString().padLeft(2, '0')}",
        "max_sks": maxSks,
        "tanggal": tanggal,
        "status_krs": statusKrs,
        "status_krs_text": statusKrsText,
        "list_krs": listKrs == null ? [] : List<dynamic>.from(listKrs!.map((x) => x.toJson())),
    };
}

class ListKr {
    int? idKrs;
    String? status;
    Kelas? kelas;
    Matakuliah? matakuliah;
    ListKrProdi? prodi;
    ListKrKelasProdi? kelasProdi;

    ListKr({
        this.idKrs,
        this.status,
        this.kelas,
        this.matakuliah,
        this.prodi,
        this.kelasProdi,
    });

    factory ListKr.fromJson(Map<String, dynamic> json) => ListKr(
        idKrs: json["id_krs"],
        status: json["status"],
        kelas: json["kelas"] == null ? null : Kelas.fromJson(json["kelas"]),
        matakuliah: json["matakuliah"] == null ? null : Matakuliah.fromJson(json["matakuliah"]),
        prodi: json["prodi"] == null ? null : ListKrProdi.fromJson(json["prodi"]),
        kelasProdi: json["kelas_prodi"] == null ? null : ListKrKelasProdi.fromJson(json["kelas_prodi"]),
    );

    Map<String, dynamic> toJson() => {
        "id_krs": idKrs,
        "status": status,
        "kelas": kelas?.toJson(),
        "matakuliah": matakuliah?.toJson(),
        "prodi": prodi?.toJson(),
        "kelas_prodi": kelasProdi?.toJson(),
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

class ListKrKelasProdi {
    dynamic idKelasProdi;
    String? namaKelasProdi;

    ListKrKelasProdi({
        this.idKelasProdi,
        this.namaKelasProdi,
    });

    factory ListKrKelasProdi.fromJson(Map<String, dynamic> json) => ListKrKelasProdi(
        idKelasProdi: json["id_kelas_prodi"],
        namaKelasProdi: json["nama_kelas_prodi"],
    );

    Map<String, dynamic> toJson() => {
        "id_kelas_prodi": idKelasProdi,
        "nama_kelas_prodi": namaKelasProdi,
    };
}

class Matakuliah {
    int? idMatakuliah;
    String? kodeMatakuliah;
    String? namaMatakuliah;
    String? sksTotal;

    Matakuliah({
        this.idMatakuliah,
        this.kodeMatakuliah,
        this.namaMatakuliah,
        this.sksTotal,
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
    String? idProdi;
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
    int? idProdi;
    String? namaProdi;

    ListProdi({
        this.idProdi,
        this.namaProdi,
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


