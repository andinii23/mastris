// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';
import '../../model/mhsbimbinganmodel.dart';
import '../../../siakad/settings/constant.dart';

class MhsBimbinganElista extends StatefulWidget {
  const MhsBimbinganElista({super.key});

  @override
  State<MhsBimbinganElista> createState() => _MhsBimbinganElistaState();
}

class _MhsBimbinganElistaState extends State<MhsBimbinganElista> {
  Future<MahasiswaBimbinganElista> getMhsBimbinganElista() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(mhsbimelista), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return MahasiswaBimbinganElista.fromJson(data);
    } else {
      return MahasiswaBimbinganElista.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mahasiswa Bimbingan Elista",
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
              child: FutureBuilder(
                  future: getMhsBimbinganElista(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(16),
                        child: ListView.builder(
                            itemCount: snapshot.data!.data.list.length,
                            itemBuilder: (context, index) {

                              if(snapshot.data!.data.list[index].stepBimbingan != "Lulus"){
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
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: mainBlueColor,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              snapshot
                                                  .data!.data.list[index].nama
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: mainWhiteColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              snapshot
                                                  .data!.data.list[index].nim
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: mainWhiteColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Tanggal Surat Tugas : ${snapshot.data!.data.list[index].tanggalSuratTugas}",
                                              style: TextStyle(
                                                color: mainWhiteColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "Prodi : ${snapshot.data!.data.list[index].namaProdi}"),
                                                Text(
                                                    "Angkatan : ${snapshot.data!.data.list[index].angkatan}"),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 2,
                                          ),
                                          Text(
                                            "Status Bimbingan",
                                            style: TextStyle(
                                              color: mainBlackColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(snapshot.data!.data.list[index]
                                              .stepBimbingan),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                         ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: snapshot
                                                    .data!
                                                    .data
                                                    .list[index]
                                                    .dosenPembimbing
                                                    .length,
                                                itemBuilder: (context, dosen) {
                                                  return Column(
                                                    children: [
                                                      if (snapshot
                                                              .data!
                                                              .data
                                                              .list[index]
                                                              .dosenPembimbing[
                                                                  dosen]
                                                              .gelarDepan
                                                              .toString() ==
                                                          "null")
                                                        (Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 5),
                                                              child: Text(
                                                                  "Pembimbing ${snapshot.data!.data.list[index].dosenPembimbing[dosen].jenis}"),
                                                            ),
                                                            Text(
                                                                " ${snapshot.data!.data.list[index].dosenPembimbing[dosen].namaDosen} ${snapshot.data!.data.list[index].dosenPembimbing[dosen].gelarBelakang}")
                                                          ],
                                                        )),
                                                      if (snapshot
                                                              .data!
                                                              .data
                                                              .list[index]
                                                              .dosenPembimbing[
                                                                  dosen]
                                                              .gelarDepan
                                                              .toString() !=
                                                          "null")
                                                        (Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 5),
                                                              child: Text(
                                                                  "Pembimbing ${snapshot.data!.data.list[index].dosenPembimbing[dosen].jenis}"),
                                                            ),
                                                            Text(
                                                                " ${snapshot.data!.data.list[index].dosenPembimbing[dosen].gelarDepan} ${snapshot.data!.data.list[index].dosenPembimbing[dosen].namaDosen} ${snapshot.data!.data.list[index].dosenPembimbing[dosen].gelarBelakang}")
                                                          ],
                                                        )),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          if (snapshot
                                                                  .data!
                                                                  .data
                                                                  .list[index]
                                                                  .dosenPembimbing[
                                                                      dosen]
                                                                  .accSeminarProposal
                                                                  .toString() !=
                                                              "null")
                                                            const SizedBox(
                                                              width: 95,
                                                              child: (Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      "Proposal"),
                                                                  Text(
                                                                      "Sudah ACC")
                                                                ],
                                                              )),
                                                            ),
                                                          // seminar hasil
                                                          if (snapshot
                                                                  .data!
                                                                  .data
                                                                  .list[index]
                                                                  .dosenPembimbing[
                                                                      dosen]
                                                                  .accSeminarHasil
                                                                  .toString() !=
                                                              "null")
                                                            const SizedBox(
                                                              width: 95,
                                                              child: (Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      "Seminar Hasil"),
                                                                  Text(
                                                                      "Sudah ACC")
                                                                ],
                                                              )),
                                                            ),

                                                          // sidang
                                                          if (snapshot
                                                                  .data!
                                                                  .data
                                                                  .list[index]
                                                                  .dosenPembimbing[
                                                                      dosen]
                                                                  .accSidang
                                                                  .toString() !=
                                                              "null")
                                                            const SizedBox(
                                                              width: 95,
                                                              child: (Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                      "Sidang"),
                                                                  Text(
                                                                      "Sudah ACC")
                                                                ],
                                                              )),
                                                            ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          const Divider(
                                            thickness: 2,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: mainWhiteColor,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(5),
                                                      bottomRight:
                                                          Radius.circular(5),
                                                    ), 
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      _detailMhsBimbingan(snapshot.data!.data.list[index].idMhsPt.toString());
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
                                                              color:
                                                                  mainBlackColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: mainBlackColor,
                                                          size: 14,
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
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }))
        ],
      ),
    );
  }

    Future _detailMhsBimbingan(String idMhsPt) async {
    SpUtil.putString("id_mhs_pt", idMhsPt);
    Navigator.pushNamed(context, 'detailmhsbim');
  }
}
