// To parse this JSON data, do
//
//     final semesterModel = semesterModelFromJson(jsonString);

import 'dart:convert';

SemesterModel semesterModelFromJson(String str) => SemesterModel.fromJson(json.decode(str));

String semesterModelToJson(SemesterModel data) => json.encode(data.toJson());

class SemesterModel {
    String idSemester;
    String semesterText;

    SemesterModel({
        required this.idSemester,
        required this.semesterText,
    });

    factory SemesterModel.fromJson(Map<String, dynamic> json) => SemesterModel(
        idSemester: json["id_semester"],
        semesterText: json["semester_text"],
    );

    Map<String, dynamic> toJson() => {
        "id_semester": idSemester,
        "semester_text": semesterText,
    };
}
