// To parse this JSON data, do
//
//     final listChatDosenModel = listChatDosenModelFromJson(jsonString);

import 'dart:convert';

ListChatDosenModel listChatDosenModelFromJson(String str) => ListChatDosenModel.fromJson(json.decode(str));

String listChatDosenModelToJson(ListChatDosenModel data) => json.encode(data.toJson());

class ListChatDosenModel {
    int code;
    String errorMessage;
    Data data;

    ListChatDosenModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory ListChatDosenModel.fromJson(Map<String, dynamic> json) => ListChatDosenModel(
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
    int idMhsPt;
    String noInduk;
    String namaMahasiswa;
    Prodi prodi;
    LastMessage? lastMessage;

    ListElement({
        required this.idMhsPt,
        required this.noInduk,
        required this.namaMahasiswa,
        required this.prodi,
        this.lastMessage,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idMhsPt: json["id_mhs_pt"],
        noInduk: json["no_induk"],
        namaMahasiswa: json["nama_mahasiswa"],
        prodi: Prodi.fromJson(json["prodi"]),
        lastMessage: json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]),
    );

    Map<String, dynamic> toJson() => {
        "id_mhs_pt": idMhsPt,
        "no_induk": noInduk,
        "nama_mahasiswa": namaMahasiswa,
        "prodi": prodi.toJson(),
        "last_message": lastMessage?.toJson(),
    };
}

class LastMessage {
    int idChat;
    int idMhsPt;
    int idPegawai;
    int idPengirim;
    dynamic dibalas;
    int tipe;
    String pesan;
    dynamic path;
    dynamic waktuRespon;
    DateTime createdAt;
    DateTime updatedAt;
    bool dariSaya;

    LastMessage({
        required this.idChat,
        required this.idMhsPt,
        required this.idPegawai,
        required this.idPengirim,
        this.dibalas,
        required this.tipe,
        required this.pesan,
        this.path,
        this.waktuRespon,
        required this.createdAt,
        required this.updatedAt,
        required this.dariSaya,
    });

    factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        idChat: json["id_chat"],
        idMhsPt: json["id_mhs_pt"],
        idPegawai: json["id_pegawai"],
        idPengirim: json["id_pengirim"],
        dibalas: json["dibalas"],
        tipe: json["tipe"],
        pesan: json["pesan"],
        path: json["path"],
        waktuRespon: json["waktu_respon"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        dariSaya: json["dari_saya"],
    );

    Map<String, dynamic> toJson() => {
        "id_chat": idChat,
        "id_mhs_pt": idMhsPt,
        "id_pegawai": idPegawai,
        "id_pengirim": idPengirim,
        "dibalas": dibalas,
        "tipe": tipe,
        "pesan": pesan,
        "path": path,
        "waktu_respon": waktuRespon,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "dari_saya": dariSaya,
    };
}

class Prodi {
    String idProdi;
    String namaProdi;

    Prodi({
        required this.idProdi,
        required this.namaProdi,
    });

    factory Prodi.fromJson(Map<String, dynamic> json) => Prodi(
        idProdi: json["id_prodi"],
        namaProdi: json["nama_prodi"],
    );

    Map<String, dynamic> toJson() => {
        "id_prodi": idProdi,
        "nama_prodi": namaProdi,
    };
}




