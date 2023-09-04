// To parse this JSON data, do
//
//     final jadwalUjianModel = jadwalUjianModelFromJson(jsonString);

import 'dart:convert';

JadwalUjianModel jadwalUjianModelFromJson(String str) => JadwalUjianModel.fromJson(json.decode(str));

String jadwalUjianModelToJson(JadwalUjianModel data) => json.encode(data.toJson());

class JadwalUjianModel {
    int code;
    String errorMessage;
    Data data;

    JadwalUjianModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory JadwalUjianModel.fromJson(Map<String, dynamic> json) => JadwalUjianModel(
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
    Mahasiswa mahasiswa;
    Penelitian penelitian;
    StepSaatIni stepSaatIni;
    Jadwal jadwal;
    List<DosenPe> dosenPembimbing;
    List<DosenPe> dosenPenguji;
    List<dynamic> fileTa;
    BeritaAcaraDosenAuth beritaAcaraDosenAuth;
    List<BeritaAcaraDosenAuth> listBeritaAcara;

    ListClass({
        required this.mahasiswa,
        required this.penelitian,
        required this.stepSaatIni,
        required this.jadwal,
        required this.dosenPembimbing,
        required this.dosenPenguji,
        required this.fileTa,
        required this.beritaAcaraDosenAuth,
        required this.listBeritaAcara,
    });

    factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        mahasiswa: Mahasiswa.fromJson(json["mahasiswa"]),
        penelitian: Penelitian.fromJson(json["penelitian"]),
        stepSaatIni: StepSaatIni.fromJson(json["step_saat_ini"]),
        jadwal: Jadwal.fromJson(json["jadwal"]),
        dosenPembimbing: List<DosenPe>.from(json["dosen_pembimbing"].map((x) => DosenPe.fromJson(x))),
        dosenPenguji: List<DosenPe>.from(json["dosen_penguji"].map((x) => DosenPe.fromJson(x))),
        fileTa: List<dynamic>.from(json["file_ta"].map((x) => x)),
        beritaAcaraDosenAuth: BeritaAcaraDosenAuth.fromJson(json["berita_acara_dosen_auth"]),
        listBeritaAcara: List<BeritaAcaraDosenAuth>.from(json["list_berita_acara"].map((x) => BeritaAcaraDosenAuth.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mahasiswa": mahasiswa.toJson(),
        "penelitian": penelitian.toJson(),
        "step_saat_ini": stepSaatIni.toJson(),
        "jadwal": jadwal.toJson(),
        "dosen_pembimbing": List<dynamic>.from(dosenPembimbing.map((x) => x.toJson())),
        "dosen_penguji": List<dynamic>.from(dosenPenguji.map((x) => x.toJson())),
        "file_ta": List<dynamic>.from(fileTa.map((x) => x)),
        "berita_acara_dosen_auth": beritaAcaraDosenAuth.toJson(),
        "list_berita_acara": List<dynamic>.from(listBeritaAcara.map((x) => x.toJson())),
    };
}

class BeritaAcaraDosenAuth {
    int idDosen;
    String namaDosen;
    String komentar;
    int status;
    String tanggalTtd;
    String statusText;

    BeritaAcaraDosenAuth({
        required this.idDosen,
        required this.namaDosen,
        required this.komentar,
        required this.status,
        required this.tanggalTtd,
        required this.statusText,
    });

    factory BeritaAcaraDosenAuth.fromJson(Map<String, dynamic> json) => BeritaAcaraDosenAuth(
        idDosen: json["id_dosen"],
        namaDosen: json["nama_dosen"],
        komentar: json["komentar"],
        status: json["status"],
        tanggalTtd: json["tanggal_ttd"],
        statusText: json["status_text"],
    );

    Map<String, dynamic> toJson() => {
        "id_dosen": idDosen,
        "nama_dosen": namaDosen,
        "komentar": komentar,
        "status": status,
        "tanggal_ttd": tanggalTtd,
        "status_text": statusText,
    };
}

class DosenPe {
    String jenis;
    String namaDosen;
    String? gelarDepan;
    String gelarBelakang;

    DosenPe({
        required this.jenis,
        required this.namaDosen,
        required this.gelarDepan,
        required this.gelarBelakang,
    });

    factory DosenPe.fromJson(Map<String, dynamic> json) => DosenPe(
        jenis: json["jenis"],
        namaDosen: json["nama_dosen"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
    );

    Map<String, dynamic> toJson() => {
        "jenis": jenis,
        "nama_dosen": namaDosen,
        "gelar_depan": gelarDepan,
        "gelar_belakang": gelarBelakang,
    };
}

class Jadwal {
    String tanggalPendaftaran;
    String tanggalValidasi;
    String waktuMulai;
    dynamic waktuSelesai;
    String namaUjian;

    Jadwal({
        required this.tanggalPendaftaran,
        required this.tanggalValidasi,
        required this.waktuMulai,
        required this.waktuSelesai,
        required this.namaUjian,
    });

    factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        tanggalPendaftaran: json["tanggal_pendaftaran"],
        tanggalValidasi: json["tanggal_validasi"],
        waktuMulai: json["waktu_mulai"],
        waktuSelesai: json["waktu_selesai"],
        namaUjian: json["nama_ujian"],
    );

    Map<String, dynamic> toJson() => {
        "tanggal_pendaftaran": tanggalPendaftaran,
        "tanggal_validasi": tanggalValidasi,
        "waktu_mulai": waktuMulai,
        "waktu_selesai": waktuSelesai,
        "nama_ujian": namaUjian,
    };
}

class Mahasiswa {
    int idMhsPt;
    String noMhs;
    String nama;
    int angkatan;

    Mahasiswa({
        required this.idMhsPt,
        required this.noMhs,
        required this.nama,
        required this.angkatan,
    });

    factory Mahasiswa.fromJson(Map<String, dynamic> json) => Mahasiswa(
        idMhsPt: json["id_mhs_pt"],
        noMhs: json["no_mhs"],
        nama: json["nama"],
        angkatan: json["angkatan"],
    );

    Map<String, dynamic> toJson() => {
        "id_mhs_pt": idMhsPt,
        "no_mhs": noMhs,
        "nama": nama,
        "angkatan": angkatan,
    };
}

class Penelitian {
    String judulSkripsi;
    String abstrak;
    String metodePenelitian;
    String jenisExplanasi;
    String jenisDataPenelitian;
    String jenisPenggunaan;

    Penelitian({
        required this.judulSkripsi,
        required this.abstrak,
        required this.metodePenelitian,
        required this.jenisExplanasi,
        required this.jenisDataPenelitian,
        required this.jenisPenggunaan,
    });

    factory Penelitian.fromJson(Map<String, dynamic> json) => Penelitian(
        judulSkripsi: json["judul_skripsi"],
        abstrak: json["abstrak"],
        metodePenelitian: json["metode_penelitian"],
        jenisExplanasi: json["jenis_explanasi"],
        jenisDataPenelitian: json["jenis_data_penelitian"],
        jenisPenggunaan: json["jenis_penggunaan"],
    );

    Map<String, dynamic> toJson() => {
        "judul_skripsi": judulSkripsi,
        "abstrak": abstrak,
        "metode_penelitian": metodePenelitian,
        "jenis_explanasi": jenisExplanasi,
        "jenis_data_penelitian": jenisDataPenelitian,
        "jenis_penggunaan": jenisPenggunaan,
    };
}

class StepSaatIni {
    int nomorStep;
    String nama;

    StepSaatIni({
        required this.nomorStep,
        required this.nama,
    });

    factory StepSaatIni.fromJson(Map<String, dynamic> json) => StepSaatIni(
        nomorStep: json["nomor_step"],
        nama: json["nama"],
    );

    Map<String, dynamic> toJson() => {
        "nomor_step": nomorStep,
        "nama": nama,
    };
}
