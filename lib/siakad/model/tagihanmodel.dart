// To parse this JSON data, do
//
//     final tagihanModel = tagihanModelFromJson(jsonString);

import 'dart:convert';

TagihanModel tagihanModelFromJson(String str) => TagihanModel.fromJson(json.decode(str));

String tagihanModelToJson(TagihanModel data) => json.encode(data.toJson());

class TagihanModel {
    TagihanModel({
        required this.code,
        required this.errorMessage,
        required this.data,
    });

    int code;
    String errorMessage;
    Data data;

    factory TagihanModel.fromJson(Map<String, dynamic> json) => TagihanModel(
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
    List<ListElement> list;

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
    ListElement({
        required this.idTagihan,
        required this.nominal,
        required this.waktuOpen,
        required this.waktuClose,
        this.waktuBayar,
        this.bank,
        this.bankRef,
        required this.keterangan,
        this.cicilanPangkal,
        this.cicilanUkt,
        this.keteranganCicilanUkt,
    });

    String idTagihan;
    String nominal;
    DateTime waktuOpen;
    DateTime waktuClose;
    dynamic waktuBayar;
    dynamic bank;
    dynamic bankRef;
    String keterangan;
    dynamic cicilanPangkal;
    dynamic cicilanUkt;
    dynamic keteranganCicilanUkt;

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        idTagihan: json["id_tagihan"],
        nominal: json["nominal"],
        waktuOpen: DateTime.parse(json["waktu_open"]),
        waktuClose: DateTime.parse(json["waktu_close"]),
        waktuBayar: json["waktu_bayar"],
        bank: json["bank"],
        bankRef: json["bank_ref"],
        keterangan: json["keterangan"],
        cicilanPangkal: json["cicilan_pangkal"],
        cicilanUkt: json["cicilan_ukt"],
        keteranganCicilanUkt: json["keterangan_cicilan_ukt"],
    );

    Map<String, dynamic> toJson() => {
        "id_tagihan": idTagihan,
        "nominal": nominal,
        "waktu_open": waktuOpen.toIso8601String(),
        "waktu_close": waktuClose.toIso8601String(),
        "waktu_bayar": waktuBayar,
        "bank": bank,
        "bank_ref": bankRef,
        "keterangan": keterangan,
        "cicilan_pangkal": cicilanPangkal,
        "cicilan_ukt": cicilanUkt,
        "keterangan_cicilan_ukt": keteranganCicilanUkt,
    };
}
