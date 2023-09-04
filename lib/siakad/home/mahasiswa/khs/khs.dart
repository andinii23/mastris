import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../../model/dafsemmodel.dart';
import '../../../model/khsdetail.dart';
import '../../../settings/constant.dart';

class KhsMhs extends StatefulWidget {
  const KhsMhs({super.key});

  @override
  State<KhsMhs> createState() => _KhsMhsState();
}

class _KhsMhsState extends State<KhsMhs> {
  dynamic idSem;

  Future<KhsDetailModel> getDetailKhs() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(
        Uri.parse(dkhs + idSem.toString()),
        headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return KhsDetailModel.fromJson(data);
    } else {
      return KhsDetailModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "KHS Mahasiswa",
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
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                DropdownSearch<DaftarSemModel>(
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
                        await http.get(Uri.parse(semestermhs), headers: header);
                    if (response.statusCode != 200) {
                      return [];
                    }
                    List allData = (json.decode(response.body)
                        as Map<String, dynamic>)["data"]["list"];

                    List<DaftarSemModel> allSemester = [];

                    for (var element in allData) {
                      allSemester.add(DaftarSemModel(
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
                    getDetailKhs();
                    setState(() {});
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: mainOrangeColor),
                    child: Text(
                      "Tampilkan KHS",
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
                Stack(children: [
                  Positioned(
                      child: FutureBuilder(
                          future: getDetailKhs(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.data.list.length,
                                  itemBuilder: (context, index) {
                                    return Container(
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
                                          Text(
                                            "Daftar KHS Semester ${snapshot.data!.data.list[index].semesterText}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: mainOrange2Color,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 15),
                                              decoration: BoxDecoration(
                                                color: mainBlueColor,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Total SKS : ${snapshot.data!.data.list[index].sksSemester}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: mainWhiteColor),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "IP : ${snapshot.data!.data.list[index].ip}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: mainWhiteColor),
                                                  ),
                                                ],
                                              )),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Column(
                                            children: [
                                              ListView.builder(
                                                  physics:
                                                      const ScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemCount: snapshot
                                                      .data!
                                                      .data
                                                      .list[index]
                                                      .listMataKuliah
                                                      .length,
                                                  itemBuilder: (context, mk) {
                                                    return Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.6,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot
                                                                        .data!
                                                                        .data
                                                                        .list[
                                                                            index]
                                                                        .listMataKuliah[
                                                                            mk]
                                                                        .kodeMatakuliah
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color:
                                                                            mainOrange2Color),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 150,
                                                                    child: Text(
                                                                      snapshot
                                                                          .data!
                                                                          .data
                                                                          .list[
                                                                              index]
                                                                          .listMataKuliah[
                                                                              mk]
                                                                          .namaMatakuliah
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              mainBlueColor),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "SKS : ${snapshot.data!.data.list[index].listMataKuliah[mk].sksTotal}",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color:
                                                                            mainBlueColor),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  7,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "Status",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color:
                                                                            mainOrange2Color),
                                                                  ),
                                                                  Text(
                                                                    snapshot
                                                                        .data!
                                                                        .data
                                                                        .list[
                                                                            index]
                                                                        .listMataKuliah[
                                                                            mk]
                                                                        .status
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color:
                                                                            mainBlueColor),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    "Nilai",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color:
                                                                            mainOrange2Color),
                                                                  ),
                                                                  if (snapshot
                                                                          .data!
                                                                          .data
                                                                          .list[
                                                                              index]
                                                                          .listMataKuliah[
                                                                              mk]
                                                                          .nilai
                                                                          .toString() !=
                                                                      "null")
                                                                    (Text(
                                                                      snapshot
                                                                          .data!
                                                                          .data
                                                                          .list[
                                                                              index]
                                                                          .listMataKuliah[
                                                                              mk]
                                                                          .nilai
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              mainBlueColor),
                                                                    )),
                                                                  if (snapshot
                                                                          .data!
                                                                          .data
                                                                          .list[
                                                                              index]
                                                                          .listMataKuliah[
                                                                              mk]
                                                                          .nilai
                                                                          .toString() ==
                                                                      "null")
                                                                    (Text(
                                                                      "-",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              mainBlueColor),
                                                                    )),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Divider(
                                                          color: mainBlackColor,
                                                        )
                                                      ],
                                                    );
                                                  })
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          })),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}