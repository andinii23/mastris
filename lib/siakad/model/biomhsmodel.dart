// To parse this JSON data, do
//
//     final bioMhsModel = bioMhsModelFromJson(jsonString);

import 'dart:convert';

BioMhsModel bioMhsModelFromJson(String str) =>
    BioMhsModel.fromJson(json.decode(str));

String bioMhsModelToJson(BioMhsModel data) => json.encode(data.toJson());

class BioMhsModel {
  int code;
  String errorMessage;
  Data data;

  BioMhsModel({
    required this.code,
    required this.errorMessage,
    required this.data,
  });

  factory BioMhsModel.fromJson(Map<String, dynamic> json) => BioMhsModel(
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
  int idMhsPt;
  String namaMahasiswa;
  String tempatLahir;
  String tanggalLahir;
  dynamic jenisKelamin;
  String alamat;
  String rt;
  dynamic dusun;
  String kelurahan;
  String kodePos;
  String alamat2;
  String rt2;
  String rw2;
  dynamic dusun2;
  String kelurahan2;
  String kodePos2;
  String telepon1;
  dynamic telepon2;
  String email;
  String hobi;
  String golonganDarah;
  dynamic jumlahSaudara;
  String aTerimaKps;
  String noKps;
  String catatan;
  String npwp;
  String fileKtp;
  String fileKk;
  String fileAkte;
  String namaAyah;
  String tanggalLahirAyah;
  String teleponAyah;
  Pekerjaan pekerjaanAyah;
  JenjangPendidikan jenjangPendidikanAyah;
  Penghasilan penghasilanAyah;
  String namaIbu;
  String tanggalLahirIbu;
  dynamic teleponIbu;
  Pekerjaan pekerjaanIbu;
  JenjangPendidikan jenjangPendidikanIbu;
  Penghasilan penghasilanIbu;
  dynamic namaWali;
  String tanggalLahirWali;
  JenjangPendidikan jenjangPendidikanWali;
  Penghasilan penghasilanWali;
  Pekerjaan pekerjaanWali;

  ListClass({
    required this.idMhsPt,
    required this.namaMahasiswa,
    required this.tempatLahir,
    required this.tanggalLahir,
    this.jenisKelamin,
    required this.alamat,
    required this.rt,
    required this.dusun,
    required this.kelurahan,
    required this.kodePos,
    required this.alamat2,
    required this.rt2,
    required this.rw2,
    required this.dusun2,
    required this.kelurahan2,
    required this.kodePos2,
    required this.telepon1,
    this.telepon2,
    required this.email,
    required this.hobi,
    required this.golonganDarah,
    this.jumlahSaudara,
    required this.aTerimaKps,
    required this.noKps,
    required this.catatan,
    required this.npwp,
    required this.fileKtp,
    required this.fileKk,
    required this.fileAkte,
    required this.namaAyah,
    required this.tanggalLahirAyah,
    required this.teleponAyah,
    required this.pekerjaanAyah,
    required this.jenjangPendidikanAyah,
    required this.penghasilanAyah,
    required this.namaIbu,
    required this.tanggalLahirIbu,
    this.teleponIbu,
    required this.pekerjaanIbu,
    required this.jenjangPendidikanIbu,
    required this.penghasilanIbu,
    this.namaWali,
    required this.tanggalLahirWali,
    required this.jenjangPendidikanWali,
    required this.penghasilanWali,
    required this.pekerjaanWali,
  });

  factory ListClass.fromJson(Map<String, dynamic> json) => ListClass(
        idMhsPt: json["id_mhs_pt"],
        namaMahasiswa: json["nama_mahasiswa"],
        tempatLahir: json["tempat_lahir"],
        tanggalLahir: json["tanggal_lahir"],
        jenisKelamin: json["jenis_kelamin"],
        alamat: json["alamat"],
        rt: json["rt"],
        dusun: json["dusun"],
        kelurahan: json["kelurahan"],
        kodePos: json["kode_pos"],
        alamat2: json["alamat2"],
        rt2: json["rt2"],
        rw2: json["rw2"],
        dusun2: json["dusun2"],
        kelurahan2: json["kelurahan2"],
        kodePos2: json["kode_pos2"],
        telepon1: json["telepon1"],
        telepon2: json["telepon2"],
        email: json["email"],
        hobi: json["hobi"],
        golonganDarah: json["golongan_darah"],
        jumlahSaudara: json["jumlah_saudara"],
        aTerimaKps: json["a_terima_kps"],
        noKps: json["no_kps"],
        catatan: json["catatan"],
        npwp: json["npwp"],
        fileKtp: json["file_ktp"],
        fileKk: json["file_kk"],
        fileAkte: json["file_akte"],
        namaAyah: json["nama_ayah"],
        tanggalLahirAyah: json["tanggal_lahir_ayah"],
        teleponAyah: json["telepon_ayah"],
        pekerjaanAyah: Pekerjaan.fromJson(json["pekerjaan_ayah"]),
        jenjangPendidikanAyah:
            JenjangPendidikan.fromJson(json["jenjang_pendidikan_ayah"]),
        penghasilanAyah: Penghasilan.fromJson(json["penghasilan_ayah"]),
        namaIbu: json["nama_ibu"],
        tanggalLahirIbu: json["tanggal_lahir_ibu"],
        teleponIbu: json["telepon_ibu"],
        pekerjaanIbu: Pekerjaan.fromJson(json["pekerjaan_ibu"]),
        jenjangPendidikanIbu:
            JenjangPendidikan.fromJson(json["jenjang_pendidikan_ibu"]),
        penghasilanIbu: Penghasilan.fromJson(json["penghasilan_ibu"]),
        namaWali: json["nama_wali"],
        tanggalLahirWali: json["tanggal_lahir_wali"],
        jenjangPendidikanWali:
            JenjangPendidikan.fromJson(json["jenjang_pendidikan_wali"]),
        penghasilanWali: Penghasilan.fromJson(json["penghasilan_wali"]),
        pekerjaanWali: Pekerjaan.fromJson(json["pekerjaan_wali"]),
      );

  Map<String, dynamic> toJson() => {
        "id_mhs_pt": idMhsPt,
        "nama_mahasiswa": namaMahasiswa,
        "tempat_lahir": tempatLahir,
        "tanggal_lahir":
            tanggalLahir,
        "jenis_kelamin": jenisKelamin,
        "alamat": alamat,
        "rt": rt,
        "dusun": dusun,
        "kelurahan": kelurahan,
        "kode_pos": kodePos,
        "alamat2": alamat2,
        "rt2": rt2,
        "rw2": rw2,
        "dusun2": dusun2,
        "kelurahan2": kelurahan2,
        "kode_pos2": kodePos2,
        "telepon1": telepon1,
        "telepon2": telepon2,
        "email": email,
        "hobi": hobi,
        "golongan_darah": golonganDarah,
        "jumlah_saudara": jumlahSaudara,
        "a_terima_kps": aTerimaKps,
        "no_kps": noKps,
        "catatan": catatan,
        "npwp": npwp,
        "file_ktp": fileKtp,
        "file_kk": fileKk,
        "file_akte": fileAkte,
        "nama_ayah": namaAyah,
        "tanggal_lahir_ayah":
            tanggalLahirAyah,
        "telepon_ayah": teleponAyah,
        "pekerjaan_ayah": pekerjaanAyah.toJson(),
        "jenjang_pendidikan_ayah": jenjangPendidikanAyah.toJson(),
        "penghasilan_ayah": penghasilanAyah.toJson(),
        "nama_ibu": namaIbu,
        "tanggal_lahir_ibu":
            tanggalLahirIbu,
        "telepon_ibu": teleponIbu,
        "pekerjaan_ibu": pekerjaanIbu.toJson(),
        "jenjang_pendidikan_ibu": jenjangPendidikanIbu.toJson(),
        "penghasilan_ibu": penghasilanIbu.toJson(),
        "nama_wali": namaWali,
        "tanggal_lahir_wali": tanggalLahirWali,
        "jenjang_pendidikan_wali": jenjangPendidikanWali.toJson(),
        "penghasilan_wali": penghasilanWali.toJson(),
        "pekerjaan_wali": pekerjaanWali.toJson(),
      };
}

class JenjangPendidikan {
  dynamic idJenjangPendidikan;
  String? namaJenjangPendidikan;

  JenjangPendidikan({
    this.idJenjangPendidikan,
    this.namaJenjangPendidikan,
  });

  factory JenjangPendidikan.fromJson(Map<String, dynamic> json) =>
      JenjangPendidikan(
        idJenjangPendidikan: json["id_jenjang_pendidikan"],
        namaJenjangPendidikan: json["nama_jenjang_pendidikan"],
      );

  Map<String, dynamic> toJson() => {
        "id_jenjang_pendidikan": idJenjangPendidikan,
        "nama_jenjang_pendidikan": namaJenjangPendidikan,
      };
}

class Pekerjaan {
  dynamic idPekerjaan;
  dynamic namaPekerjaan;

  Pekerjaan({
    this.idPekerjaan,
    this.namaPekerjaan,
  });

  factory Pekerjaan.fromJson(Map<String, dynamic> json) => Pekerjaan(
        idPekerjaan: json["id_pekerjaan"],
        namaPekerjaan: json["nama_pekerjaan"],
      );

  Map<String, dynamic> toJson() => {
        "id_pekerjaan": idPekerjaan,
        "nama_pekerjaan": namaPekerjaan,
      };
}

class Penghasilan {
  dynamic idPenghasilan;
  dynamic namaPenghasilan;

  Penghasilan({
    this.idPenghasilan,
    this.namaPenghasilan,
  });

  factory Penghasilan.fromJson(Map<String, dynamic> json) => Penghasilan(
        idPenghasilan: json["id_penghasilan"],
        namaPenghasilan: json["nama_penghasilan"],
      );

  Map<String, dynamic> toJson() => {
        "id_penghasilan": idPenghasilan,
        "nama_penghasilan": namaPenghasilan,
      };
}
