// To parse this JSON data, do
//
//     final daftarSemModel = daftarSemModelFromJson(jsonString);

import 'dart:convert';

DaftarSemModel daftarSemModelFromJson(String str) => DaftarSemModel.fromJson(json.decode(str));

String daftarSemModelToJson(DaftarSemModel data) => json.encode(data.toJson());

class DaftarSemModel {
    String idSemester;
    String semesterText;

    DaftarSemModel({
        required this.idSemester,
        required this.semesterText,
    });

    factory DaftarSemModel.fromJson(Map<String, dynamic> json) => DaftarSemModel(
        idSemester: json["id_semester"],
        semesterText: json["semester_text"],
    );

    Map<String, dynamic> toJson() => {
        "id_semester": idSemester,
        "semester_text": semesterText,
    };

    @override

    String toString() => semesterText;
}
