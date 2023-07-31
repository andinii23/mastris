// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';

import '../../../model/mkajarmodel.dart';
import '../../../model/semmodel.dart';
import '../../../settings/constant.dart';


class MkAjar extends StatefulWidget {
  const MkAjar({super.key});

  @override
  State<MkAjar> createState() => _MkAjarState();
}

class _MkAjarState extends State<MkAjar> {
  String? idSem;
  Future<MkAjarModel> getMkAjar() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(matakuliahajar + idSem!), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return MkAjarModel.fromJson(data);
    } else {
      return MkAjarModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Matakuliah Ampu",
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
                  var response = await http.get(Uri.parse(semester), headers: header);
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
                  getMkAjar();
                  setState(() {});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: mainOrangeColor),
                  child: Text(
                    "Tampilkan Matakuliah Ajar",
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
                      future: getMkAjar(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data.list.length,
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
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: mainOrange2Color,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                            ),
                                          ),
                                          child: Text(
                                            "JUMLAH KELAS : ${snapshot.data!.data.list[index].jumlahKelas.toString()}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: mainWhiteColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          children: [
                                            ListView.builder(
                                                physics: const ScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: snapshot
                                                    .data!
                                                    .data
                                                    .list[index]
                                                    .listKelas
                                                    .length,
                                                itemBuilder: (context, kls) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  16),
                                                          topRight:
                                                              Radius.circular(
                                                                  16),
                                                        ),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: const Color(
                                                                    0xFF1E3B78)
                                                                .withOpacity(
                                                                    0.1),
                                                            spreadRadius: 5,
                                                            blurRadius: 4,
                                                            offset: const Offset(
                                                                0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(8),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        mainBlueColor,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              5),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              5),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    "${snapshot.data!.data.list[index].listKelas[kls].matakuliah.kodeMatakuliah.toString()} : ${snapshot.data!.data.list[index].listKelas[kls].matakuliah.namaMatakuliah.toString()}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color:
                                                                            mainWhiteColor,
                                                                        fontSize:
                                                                            16,
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
                                                              if(snapshot.data!.data.list[index].listKelas[kls].kelasProdi.namaKelasProdi.toString()!="null")
                                                              (Text(
                                                                "Ruang ${snapshot.data!.data.list[index].listKelas[kls].kodeKelas.toString()} ${snapshot.data!.data.list[index].listKelas[kls].kelasProdi.namaKelasProdi.toString()}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color:
                                                                        mainBlueColor,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                                if(snapshot.data!.data.list[index].listKelas[kls].kelasProdi.namaKelasProdi.toString()=="null")
                                                              (Text(
                                                                "Ruang ${snapshot.data!.data.list[index].listKelas[kls].kodeKelas.toString()}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color:
                                                                        mainBlueColor,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                              Text(
                                                                "Jumlah Mahasiswa : ${snapshot.data!.data.list[index].listKelas[kls].jumlahMahasiswa.toString()}",
                                                                 textAlign: TextAlign.center,
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      mainBlueColor,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Jumlah SKS : ${snapshot.data!.data.list[index].listKelas[kls].matakuliah.sksTotal.toString()}",
                                                                 textAlign: TextAlign.center,
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      mainBlueColor,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Program Studi : ${snapshot.data!.data.list[index].listKelas[kls].prodi.namaProdi.toString()}",
                                                                textAlign: TextAlign.center,
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      mainBlueColor,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Divider(
                                                            color:
                                                                mainBlackColor,
                                                            thickness: 1,
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "Jadwal",
                                                                style: TextStyle(
                                                                    color:
                                                                        mainOrange2Color,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                "${snapshot.data!.data.list[index].listKelas[kls].hari.toString()}, ${snapshot.data!.data.list[index].listKelas[kls].jamMulai.toString()} - ${snapshot.data!.data.list[index].listKelas[kls].jamSelesai.toString()}",
                                                                 textAlign: TextAlign.center,
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      mainOrange2Color,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data!
                                                                    .data
                                                                    .list[index]
                                                                    .listKelas[
                                                                        kls]
                                                                    .ruangKuliah
                                                                    .namaRuang
                                                                    .toString(),
                                                                 textAlign: TextAlign.center,
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      mainOrange2Color,
                                                                  fontSize: 14,
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
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(8),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        mainOrange2Color,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              5),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              5),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      _detailAjar(snapshot
                                                                          .data!
                                                                          .data
                                                                          .list[
                                                                              index]
                                                                          .listKelas[
                                                                              kls]
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
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: mainWhiteColor,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold),
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
                                                })
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
              ])
            ],
          ))
        ],
      ),
    );
  }
  Future _detailAjar(String idKelas) async {
    SpUtil.putString("id_kelas", idKelas);
    Navigator.pushNamed(context, 'detailmkajar');
  }
}
