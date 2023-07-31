// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
    int code;
    String errorMessage;
    Data data;

    ChatModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
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
    int idChat;
    int idMhsPt;
    int idDosen;
    bool dariSaya;
    int tipe;
    String namaPengirim;
    String pesan;

    ListElement({
        required this.idChat,
        required this.idMhsPt,
        required this.idDosen,
        required this.dariSaya,
        required this.tipe,
        required this.namaPengirim,
        required this.pesan,
    });

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idChat: json["id_chat"],
        idMhsPt: json["id_mhs_pt"],
        idDosen: json["id_dosen"],
        dariSaya: json["dari_saya"],
        tipe: json["tipe"],
        namaPengirim: json["nama_pengirim"],
        pesan: json["pesan"],
    );

    Map<String, dynamic> toJson() => {
        "id_chat": idChat,
        "id_mhs_pt": idMhsPt,
        "id_dosen": idDosen,
        "dari_saya": dariSaya,
        "tipe": tipe,
        "nama_pengirim": namaPengirim,
        "pesan": pesan,
    };
}
