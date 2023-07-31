// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:sp_util/sp_util.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/cetakkhsmodel.dart';
import '../../model/cetakkrsmodel.dart';
import '../../model/cetakktmmodel.dart';
import '../../model/cetaktranskipmodel.dart';
import '../../model/dafsemmodel.dart';
import '../../settings/constant.dart';


class CetakPage extends StatefulWidget {
  const CetakPage({Key? key}) : super(key: key);

  @override
  State<CetakPage> createState() => _CetakPageState();
}

class _CetakPageState extends State<CetakPage> {
  Dio dio = Dio();
  String? idSem;

  Future<CetakKtmModel> getKtm() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.post(Uri.parse(ktm), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      final cetakKtmModel = cetakKtmModelFromJson(response.body);
      SpUtil.putString("url_ktm", cetakKtmModel.data.list.url);
      SpUtil.putString("id_mhs_pt_ktm", cetakKtmModel.data.list.idMhsPt);
      return CetakKtmModel.fromJson(data);
    } else {
      return CetakKtmModel.fromJson(data);
    }
  }

  Future<CetakKrsModel> getKrs() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.post(Uri.parse(cetakkrs), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      final cetakKrsModel = cetakKrsModelFromJson(response.body);
      SpUtil.putString("url_krs", cetakKrsModel.data.list.url);
      SpUtil.putString("id_mhs_pt_url", cetakKrsModel.data.list.idMhsPt);
      return CetakKrsModel.fromJson(data);
    } else {
      return CetakKrsModel.fromJson(data);
    }
  }

  Future<CetakKhsModel> getCetakKhs() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.post(Uri.parse(cetakkrs), headers: header, body: {
      "id_mhs_pt": SpUtil.getString("id_mhss_pt"),
      "id_semester": idSem,
    });
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      final cetakKhsModel = cetakKhsModelFromJson(response.body);
      // print(cetakKhsModel);
      SpUtil.putString("url_khs", cetakKhsModel.data.list.url);
      SpUtil.putString("id_mhs_pt_khs", cetakKhsModel.data.list.idMhsPt);
      SpUtil.putString("id_semester_khs", cetakKhsModel.data.list.idSemester);
      return CetakKhsModel.fromJson(data);
    } else {
      return CetakKhsModel.fromJson(data);
    }
  }

  Future<CetakTranskipModel> getTranskip() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.post(Uri.parse(cetaktranskip), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      final cetakTranskipModel = cetakTranskipModelFromJson(response.body);
      SpUtil.putString("url_transkip", cetakTranskipModel.data.list.url);
      SpUtil.putString(
          "id_mhs_pt_transkip", cetakTranskipModel.data.list.idMhsPt);
      return CetakTranskipModel.fromJson(data);
    } else {
      return CetakTranskipModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Cetak",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 20,
                color: mainBlackColor,
                fontWeight: FontWeight.w700),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pushNamed(context, 'navbar');
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: SizedBox(
                                child: FutureBuilder(
                                    future: getKtm(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return InkWell(
                                          onTap: () {
                                            _downloadKtm();
                                          },
                                          child: Container(
                                            width: 50,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: mainBlueColor),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Download KTM",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: mainWhiteColor,
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.download,
                                                  color: mainWhiteColor,
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    })),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Batal",
                                  style: TextStyle(color: mainBlueColor),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1E3B78),
                          Color.fromRGBO(120, 30, 30, 1),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(5, 10),
                          blurRadius: 20,
                          color: const Color(0xFF1E3B78).withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Cetak KTM",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: mainWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: SizedBox(
                                child: FutureBuilder(
                                    future: getKrs(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return InkWell(
                                          onTap: () {
                                            _downloadKrs();
                                          },
                                          child: Container(
                                            width: 50,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: mainBlueColor),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Download KRS",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: mainWhiteColor,
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.download,
                                                  color: mainWhiteColor,
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    })),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Batal",
                                  style: TextStyle(color: mainBlueColor),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: Container(
                 
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(120, 30, 30, 1),
                          Color(0xFF1E3B78),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(5, 10),
                          blurRadius: 20,
                          color: const Color(0xFF1E3B78).withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Cetak KRS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: mainWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: SizedBox(
                                child: Column(
                              children: [
                                DropdownSearch<DaftarSemModel>(
                                  mode: Mode.MENU,
                                  // showSearchBox: true,
                                  popupItemBuilder: (context, item, isSelected) =>
                                      ListTile(
                                    title: Text(item.semesterText),
                                  ),
                                  onChanged: (value) => idSem = value?.idSemester,
                                  dropdownBuilder: (context, selectedItem) =>
                                      Text(selectedItem?.semesterText ??
                                          "Pilih Semester"),
                                  onFind: (text) async {
                                    var header = {
                                      "Authorization":
                                          "Bearer ${SpUtil.getString("token")}"
                                    };
                                    var response = await http.get(Uri.parse(semestermhs),
                                        headers: header);
                                    if (response.statusCode != 200) {
                                      return [];
                                    }
                                    List allData = (json.decode(response.body)
                                        as Map<String, dynamic>)["data"]["list"];
        
                                    List<DaftarSemModel> allSemester = [];
        
                                    for (var element in allData) {
                                      allSemester.add(DaftarSemModel(
                                          idSemester: element["id_semester"],
                                          semesterText:
                                              element["semester_text"]));
                                    }
                                    setState(() {
                                      // getCetakKhs();
                                    });
                                    return allSemester;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    getCetakKhs();
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(10),
                                    decoration:
                                        BoxDecoration(color: mainBlueColor),
                                    child: Text(
                                      "Get Semester",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: mainWhiteColor, fontSize: 14),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    _downloadKhs();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration:
                                        BoxDecoration(color: mainBlueColor),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Download KHS",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: mainWhiteColor,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.download,
                                          color: mainWhiteColor,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Batal",
                                  style: TextStyle(color: mainBlueColor),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: Container(
                  
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1E3B78),
                          Color.fromRGBO(120, 30, 30, 1),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(5, 10),
                          blurRadius: 20,
                          color: const Color(0xFF1E3B78).withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Cetak KHS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: mainWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: SizedBox(
                                child: FutureBuilder(
                                    future: getTranskip(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return InkWell(
                                          onTap: () {
                                            _downloadTranskip();
                                          },
                                          child: Container(
                                            width: 50,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: mainBlueColor),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Download Transkip",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: mainWhiteColor,
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.download,
                                                  color: mainWhiteColor,
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    })),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Batal",
                                  style: TextStyle(color: mainBlueColor),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: Container(
                   
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(120, 30, 30, 1),
                          Color(0xFF1E3B78),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(5, 10),
                          blurRadius: 20,
                          color: const Color(0xFF1E3B78).withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Cetak Transkip",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: mainWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _viewAndSavePdf(String filePath) async {
    if (await File(filePath).exists()) {
      // Tampilkan PDF
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFView(
            filePath: filePath,
          ),
        ),
      );

      // Salin file PDF ke direktori penyimpanan utama
      var appDocDir = await getApplicationDocumentsDirectory();
      var appDocPath = appDocDir.path;
      await File(filePath).copy('$appDocPath/krs.pdf');

      print("File saved at: $appDocPath/krs.pdf");
    } else {
      print("File not found");
    }
  }

  Future<void> _downloadKtm() async {
    try {
      var response = await dio.post(
        SpUtil.getString("url_ktm")!,
        data: {"id_mhs_pt": SpUtil.getString("id_mhs_pt_ktm")},
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        var externalDir = await getExternalStorageDirectory();
        var customDirPath = "${externalDir!.path}/Download";
        Directory customDir = Directory(customDirPath);
        if (!await customDir.exists()) {
          await customDir.create(recursive: true);
        }
        var filePath = "$customDirPath/ktm.pdf";

        await File(filePath).writeAsBytes(response.data, flush: true);

        print("File saved at: $filePath");

        await _viewAndSavePdf(filePath);
      } else {
        print("Download failed");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _downloadKrs() async {
    try {
      var response = await dio.post(
        SpUtil.getString("url_krs")!,
        data: {"id_mhs_pt": SpUtil.getString("id_mhs_pt_url")},
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        var externalDir = await getExternalStorageDirectory();
        var customDirPath = "${externalDir!.path}/Download";
        Directory customDir = Directory(customDirPath);
        if (!await customDir.exists()) {
          await customDir.create(recursive: true);
        }
        var filePath = "$customDirPath/krs.pdf";

        await File(filePath).writeAsBytes(response.data, flush: true);

        print("File saved at: $filePath");

        await _viewAndSavePdf(filePath);
      } else {
        print("Download failed");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _downloadKhs() async {
    try {
      var response = await dio.post(
        SpUtil.getString("url_khs")!,
        data: {
          "id_mhs_pt": SpUtil.getString("id_mhs_pt_khs"),
          "id_semester": SpUtil.getString("id_semester_khs"),
        },
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        var externalDir = await getExternalStorageDirectory();
        var customDirPath = "${externalDir!.path}/Download";
        Directory customDir = Directory(customDirPath);
        if (!await customDir.exists()) {
          await customDir.create(recursive: true);
        }
        var filePath = "$customDirPath/khs.pdf";

        await File(filePath).writeAsBytes(response.data, flush: true);

        print("File saved at: $filePath");

        await _viewAndSavePdf(filePath);
      } else {
        print("Download failed");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _downloadTranskip() async {
    try {
      var response = await dio.post(
        SpUtil.getString("url_transkip")!,
        data: {
          "id_mhs_pt": SpUtil.getString("id_mhs_pt_transkip"),
        },
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        var externalDir = await getExternalStorageDirectory();
        var customDirPath = "${externalDir!.path}/Download";
        Directory customDir = Directory(customDirPath);
        if (!await customDir.exists()) {
          await customDir.create(recursive: true);
        }
        var filePath = "$customDirPath/transkip.pdf";

        await File(filePath).writeAsBytes(response.data, flush: true);

        print("File saved at: $filePath");

        await _viewAndSavePdf(filePath);
      } else {
        print("Download failed");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
