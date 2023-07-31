// ignore_for_file: import_of_legacy_library_into_null_safe, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';
import '../../../model/mkajardetail.dart';
import '../../../settings/constant.dart';

class DetailMkAjar extends StatefulWidget {
  const DetailMkAjar({super.key});

  @override
  State<DetailMkAjar> createState() => _DetailMkAjarState();
}

class _DetailMkAjarState extends State<DetailMkAjar>
    with TickerProviderStateMixin {
  Future<MkAjarDetailModel> getDetailMkAjar() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(detailmkajar + SpUtil.getString("id_kelas")!),
        headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return MkAjarDetailModel.fromJson(data);
    } else {
      return MkAjarDetailModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Detail Matakuliah Ajar",
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
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: getDetailMkAjar(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "PROGRAM STUDI ${snapshot.data!.data.list.prodi.namaProdi.toUpperCase().toString()}",
                                      style: TextStyle(
                                        color: mainBlueColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      // color: Colors.amber,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Text(
                                                  "Matakuliah",
                                                  style: TextStyle(
                                                    color: mainBlackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                    color: mainBlackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Text(
                                                  snapshot
                                                      .data!
                                                      .data
                                                      .list
                                                      .matakuliah
                                                      .namaMatakuliah.toString(),
                                                  style: TextStyle(
                                                    color: mainBlackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Text(
                                                  "Jumlah SKS",
                                                  style: TextStyle(
                                                    color: mainBlackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                    color: mainBlackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Text(
                                                  snapshot.data!.data.list
                                                      .matakuliah.sksTotal.toString(),
                                                  style: TextStyle(
                                                    color: mainBlackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Text(
                                                  "Jadwal",
                                                  style: TextStyle(
                                                    color: mainBlackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                    color: mainBlackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Text(
                                                  "${snapshot.data!.data.list.hari.toString()}, ${snapshot.data!.data.list.jamMulai.toString()} - ${snapshot.data!.data.list.jamSelesai.toString()}",
                                                  style: TextStyle(
                                                    color: mainBlackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Text(
                                                  "Ruang",
                                                  style: TextStyle(
                                                    color: mainBlackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                    color: mainBlackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Text(
                                                  snapshot.data!.data.list
                                                      .ruangKuliah.namaRuang.toString(),
                                                  style: TextStyle(
                                                    color: mainBlackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // tabbar
                            SizedBox(
                              child: TabBar(
                                  controller: _tabController,
                                  labelColor: mainBlackColor,
                                  unselectedLabelColor: Colors.grey,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicatorColor: mainBlueColor,
                                  tabs: const [
                                    Tab(
                                      text: "Daftar Mahasiswa",
                                    ),
                                    Tab(
                                      text: "Nilai",
                                    )
                                  ]),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                height:
                                    MediaQuery.of(context).size.height / 1.6,
                                width: double.maxFinite,
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF1E3B78)
                                                .withOpacity(0.1),
                                            spreadRadius: 5,
                                            blurRadius: 4,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            decoration: BoxDecoration(
                                              color: mainWhiteColor,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                              ),
                                            ),
                                            child: Text(
                                              "Daftar Mahasiswa",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: mainBlueColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 2,
                                            color: mainBlueColor,
                                          ),
                                          Expanded(
                                            // Wrap ListView.builder with Expanded
                                            child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: snapshot.data!.data
                                                  .list.mahasiswa.length,
                                              itemBuilder: (context, mhs) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2,
                                                            child: Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .list
                                                                  .mahasiswa[
                                                                      mhs]
                                                                  .namaMahasiswa
                                                                  .toUpperCase().toString(),
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .grey
                                                                    .shade800,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            snapshot
                                                                .data!
                                                                .data
                                                                .list
                                                                .mahasiswa[mhs]
                                                                .noMhs.toString(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors.grey
                                                                  .shade800,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //tab nilai
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF1E3B78)
                                                .withOpacity(0.1),
                                            spreadRadius: 5,
                                            blurRadius: 4,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            decoration: BoxDecoration(
                                              color: mainWhiteColor,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                              ),
                                            ),
                                            child: Text(
                                              "Daftar Nilai Mahasiswa",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: mainBlueColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 2,
                                            color: mainBlueColor,
                                          ),
                                          Expanded(
                                            // Wrap ListView.builder with Expanded
                                            child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: snapshot.data!.data
                                                  .list.mahasiswa.length,
                                              itemBuilder: (context, mhs) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    2,
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .data
                                                                      .list
                                                                      .mahasiswa[
                                                                          mhs]
                                                                      .namaMahasiswa
                                                                      .toUpperCase().toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade800,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    2,
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .data
                                                                      .list
                                                                      .mahasiswa[
                                                                          mhs]
                                                                      .noMhs.toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade800,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text("Nilai",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade800,
                                                                  ),),
                                                                  if(snapshot.data!.data.list.mahasiswa[mhs].nilai.toString()!="null")
                                                              (Text(snapshot.data!.data.list.mahasiswa[mhs].nilai.toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade800,
                                                                  ),)),
                                                                  if(snapshot.data!.data.list.mahasiswa[mhs].nilai.toString()=="null")
                                                              (const Text("-"))
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }))
          ],
        ));
  }
}
