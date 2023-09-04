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
    bool statusRps;
    String kodeKelas;
    String jamMulai;
    String jamSelesai;
    String hari;
    int idSemester;
    int jumlahMahasiswa;
    RuangKuliah ruangKuliah;
    dynamic kelasProdi;
    Matakuliah matakuliah;
    Prodi prodi;
    List<Mahasiswa> mahasiswa;
    List<Dosen> dosen;
    List<ListMonitoringPerkuliahan> listMonitoringPerkuliahan;

    ListClass({
        required this.idKelas,
        required this.statusRps,
        required this.kodeKelas,
        required this.jamMulai,
        required this.jamSelesai,
        required this.hari,
        required this.idSemester,
        required this.jumlahMahasiswa,
        required this.ruangKuliah,
        this.kelasProdi,
        required this.matakuliah,
        required this.prodi,
        required this.mahasiswa,
        required this.dosen,
        required this.listMonitoringPerkuliahan,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        idKelas: json["id_kelas"],
        statusRps: json["status_rps"],
        kodeKelas: json["kode_kelas"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        hari: json["hari"],
        idSemester: json["id_semester"],
        jumlahMahasiswa: json["jumlah_mahasiswa"],
        ruangKuliah: RuangKuliah.fromJson(json["ruang_kuliah"]),
        kelasProdi: json["kelas_prodi"] ,
        matakuliah:Matakuliah.fromJson(json["matakuliah"]),
        prodi: Prodi.fromJson(json["prodi"]),
        mahasiswa: List<Mahasiswa>.from(json["mahasiswa"]!.map((x) => Mahasiswa.fromJson(x))),
        dosen: List<Dosen>.from(json["dosen"]!.map((x) => Dosen.fromJson(x))),
        listMonitoringPerkuliahan: json["list_monitoring_perkuliahan"] == null ? [] : List<ListMonitoringPerkuliahan>.from(json["list_monitoring_perkuliahan"]!.map((x) => ListMonitoringPerkuliahan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_kelas": idKelas,
        "status_rps": statusRps,
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
        "mahasiswa": List<dynamic>.from(mahasiswa.map((x) => x.toJson())),
        "dosen": List<dynamic>.from(dosen.map((x) => x.toJson())),
        "list_monitoring_perkuliahan": List<dynamic>.from(listMonitoringPerkuliahan.map((x) => x.toJson())),
    };
}

class Dosen {
    dynamic idDosen;
    dynamic namaPegawai;
    dynamic gelarDepan;
    dynamic gelarBelakang;
    dynamic xValue;
    dynamic idPegawai;

    Dosen({
        this.idDosen,
        this.namaPegawai,
        this.gelarDepan,
        this.gelarBelakang,
        this.xValue,
        this.idPegawai,
    });

    factory Dosen.fromJson(Map<String, dynamic> json) => Dosen(
        idDosen: json["id_dosen"],
        namaPegawai: json["nama_pegawai"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
        xValue: json["x_value"],
        idPegawai: json["id_pegawai"],
    );

    Map<String, dynamic> toJson() => {
        "id_dosen": idDosen,
        "nama_pegawai": namaPegawai,
        "gelar_depan": gelarDepan,
        "gelar_belakang": gelarBelakang,
        "x_value": xValue,
        "id_pegawai": idPegawai,
    };
}


class ListMonitoringPerkuliahan {
    int idMonitoringPerkuliahan;
    int idKelas;
    String pertemuanKe;
    dynamic tanggal;
    String jamMulai;
    String jamSelesai;
    String materi;
    List<Dosen> dosen;
    int statusSiremun;
    String jamMulaiKuliah;
    String jamSelesaiKuliah;
    String hari;
    dynamic kodeMatakuliah;
    dynamic namaMatakuliah;
    Kehadiran kehadiran;

    ListMonitoringPerkuliahan({
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
        this.kodeMatakuliah,
        this.namaMatakuliah,
        required this.kehadiran,
    });

    factory ListMonitoringPerkuliahan.fromJson(Map<String, dynamic> json) => ListMonitoringPerkuliahan(
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

class Kehadiran {
    dynamic hadir;
    dynamic absen;
    dynamic izin;

    Kehadiran({
        this.hadir,
        this.absen,
        this.izin,
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


class Mahasiswa {
    dynamic idMhsPt;
    dynamic nilai;
    dynamic noMhs;
    dynamic angkatan;
    dynamic namaMahasiswa;
    dynamic idProdi;
    dynamic namaProdi;

    Mahasiswa({
        this.idMhsPt,
        this.nilai,
        this.noMhs,
        this.angkatan,
        this.namaMahasiswa,
        this.idProdi,
        this.namaProdi,
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
    dynamic idMatakuliah;
    dynamic namaMatakuliah;
    dynamic kodeMatakuliah;
    dynamic uploadNilai;
    dynamic sksTotal;

    Matakuliah({
        this.idMatakuliah,
        this.namaMatakuliah,
        this.kodeMatakuliah,
        this.uploadNilai,
        this.sksTotal,
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
    dynamic namaProdi;
    dynamic strata;

    Prodi({
        this.namaProdi,
        this.strata,
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


