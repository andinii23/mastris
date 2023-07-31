// ignore_for_file: unnecessary_null_comparison, import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';

import '../../../model/monitorkuliahmodel.dart';
import '../../../model/semmodel.dart';
import '../../../settings/constant.dart';

class MonitoringKuliah extends StatefulWidget {
  const MonitoringKuliah({super.key});

  @override
  State<MonitoringKuliah> createState() => _MonitoringKuliahState();
}

class _MonitoringKuliahState extends State<MonitoringKuliah> {
  String? idSem;
  Future<MonitoringKuliahModel> getMonitor() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response =
        await http.get(Uri.parse(monitorkuliah + idSem!), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      SpUtil.putString("id_sem", idSem!);
      return MonitoringKuliahModel.fromJson(data);
    } else {
      return MonitoringKuliahModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Monitoring Kuliah",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 20, color: mainBlackColor, fontWeight: FontWeight.w700),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pushNamed(context, 'homedosen');
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                DropdownSearch<SemesterModel>(
                  mode: Mode.MENU,
                  // showSearchBox: true,
                  popupItemBuilder: (context, item, isSelected) => ListTile(
                    title: Text(item.semesterText),
                  ),
                  onChanged: (value) => idSem = value?.idSemester,
                  dropdownBuilder: (context, selectedItem) =>
                      Text(selectedItem?.semesterText ?? "Pilih Semester"),
                  onFind: (text) async {
                    var header = {
                      "Authorization": "Bearer ${SpUtil.getString("token")}"
                    };
                    var response =
                        await http.get(Uri.parse(semester), headers: header);
                    if (response.statusCode != 200) {
                      return [];
                    }
                    List allData = (json.decode(response.body)
                        as Map<String, dynamic>)["data"]["list"];
                    List<SemesterModel> allSemester = [];

                    for (var element in allData) {
                      allSemester.add(SemesterModel(
                          idSemester: element["id_semester"],
                          semesterText: element["semester_text"]));
                    }

                    return allSemester;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    getMonitor();
                    setState(() {});
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: mainOrangeColor),
                    child: Text(
                      "Tampilkan Monitoring",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: mainWhiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Positioned(
                      child: FutureBuilder(
                          future: getMonitor(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount:
                                      snapshot.data!.data.list.listKelas.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF1E3B78)
                                                  .withOpacity(0.1),
                                              spreadRadius: 5,
                                              blurRadius: 4,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: mainBlueColor,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(5),
                                                        topRight:
                                                            Radius.circular(5),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "${snapshot.data!.data.list.listKelas[index].matakuliah.kodeMatakuliah.toString()} : ${snapshot.data!.data.list.listKelas[index].matakuliah.namaMatakuliah.toString()}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: mainWhiteColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "Dosen Pengampu",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: mainBlueColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    itemCount: snapshot
                                                        .data!
                                                        .data
                                                        .list
                                                        .listKelas[index]
                                                        .dosen
                                                        .length,
                                                    itemBuilder:
                                                        (context, dosen) {
                                                      if (snapshot
                                                              .data!
                                                              .data
                                                              .list
                                                              .listKelas[index]
                                                              .dosen[dosen]
                                                              .gelarDepan !=
                                                          null) {
                                                        return Center(
                                                          child: Text(
                                                            "${snapshot.data!.data.list.listKelas[index].dosen[dosen].gelarDepan.toString()} ${snapshot.data!.data.list.listKelas[index].dosen[dosen].namaPegawai.toString()} ${snapshot.data!.data.list.listKelas[index].dosen[dosen].gelarBelakang.toString()}",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color:
                                                                  mainBlueColor,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Center(
                                                          child: Text(
                                                            "${snapshot.data!.data.list.listKelas[index].dosen[dosen].namaPegawai.toString()} ${snapshot.data!.data.list.listKelas[index].dosen[dosen].gelarBelakang.toString()}",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color:
                                                                  mainBlueColor,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    }),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Column(
                                              children: [
                                                if (snapshot
                                                        .data!
                                                        .data
                                                        .list
                                                        .listKelas[index]
                                                        .kelasProdi
                                                        .namaKelasProdi
                                                        .toString() !=
                                                    "null")
                                                  (Text(
                                                    "Ruang ${snapshot.data!.data.list.listKelas[index].kodeKelas.toString()} ${snapshot.data!.data.list.listKelas[index].kelasProdi.namaKelasProdi.toString()}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: mainBlueColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                if (snapshot
                                                        .data!
                                                        .data
                                                        .list
                                                        .listKelas[index]
                                                        .kelasProdi
                                                        .namaKelasProdi
                                                        .toString() ==
                                                    "null")
                                                  (Text(
                                                    "Ruang ${snapshot.data!.data.list.listKelas[index].kodeKelas.toString()}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: mainBlueColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .data
                                                      .list
                                                      .listKelas[index]
                                                      .ruangKuliah
                                                      .namaRuang
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: mainBlueColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  "Jumlah SKS : ${snapshot.data!.data.list.listKelas[index].matakuliah.sksTotal.toString()}",
                                                  style: TextStyle(
                                                    color: mainBlueColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  "Jumlah Mahasiswa : ${snapshot.data!.data.list.listKelas[index].jumlahMahasiswa.toString()}",
                                                  style: TextStyle(
                                                      color: mainBlueColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Divider(
                                              color: mainBlackColor,
                                              thickness: 1,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 80,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Hari",
                                                        style: TextStyle(
                                                            color:
                                                                mainOrange2Color,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data!
                                                            .data
                                                            .list
                                                            .listKelas[index]
                                                            .hari
                                                            .toString(),
                                                        style: TextStyle(
                                                          color:
                                                              mainOrange2Color,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 106,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Jam Mulai",
                                                        style: TextStyle(
                                                            color:
                                                                mainOrange2Color,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data!
                                                            .data
                                                            .list
                                                            .listKelas[index]
                                                            .jamMulai
                                                            .toString(),
                                                        style: TextStyle(
                                                          color:
                                                              mainOrange2Color,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 106,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Jam Selesai",
                                                        style: TextStyle(
                                                            color:
                                                                mainOrange2Color,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data!
                                                            .data
                                                            .list
                                                            .listKelas[index]
                                                            .jamSelesai
                                                            .toString(),
                                                        style: TextStyle(
                                                          color:
                                                              mainOrange2Color,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: mainOrange2Color,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        bottomLeft:
                                                            Radius.circular(5),
                                                        bottomRight:
                                                            Radius.circular(5),
                                                      ),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        _detailMonitor(snapshot
                                                            .data!
                                                            .data
                                                            .list
                                                            .listKelas[index]
                                                            .idKelas
                                                            .toString());
                                                      },
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Detail",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color:
                                                                    mainWhiteColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            color:
                                                                mainWhiteColor,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return const Center(
                                child: Text(""),
                              );
                            }
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _detailMonitor(String idKelas) async {
    SpUtil.putString("id_kelass", idKelas);
    Navigator.pushNamed(context, 'monitorperkelas');
  }
}
