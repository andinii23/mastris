import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../../../model/kurikulumkonfoutboundmodel.dart';
import '../../../../model/monitorkuliahmodel.dart';
import '../../../../settings/constant.dart';

class KurikulumOutbound extends StatefulWidget {
  const KurikulumOutbound({super.key});

  @override
  State<KurikulumOutbound> createState() => _KurikulumOutboundState();
}

class _KurikulumOutboundState extends State<KurikulumOutbound> {
  Future<MonitoringKuliahModel> getDetailKelas() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(
        Uri.parse(
            "$detailkrs_kelasoutbound${SpUtil.getString("id_mk_asal")}/${SpUtil.getString("id_matakuliah")}"),
        headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return MonitoringKuliahModel.fromJson(data);
    } else {
      return MonitoringKuliahModel.fromJson(data);
    }
  }

  Future<KurikulumOutboundKonfModel> getKonfOutbound() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(
        Uri.parse("https://ws.unja.ac.id/api/siakad/kurikulum-mahasiswa?exclude_krs=1"),
        headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return KurikulumOutboundKonfModel.fromJson(data);
    } else {
      return KurikulumOutboundKonfModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Kurikulum Outbound Mahasiswa",
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
          //  Text(SpUtil.getString("id_mk_asal")),
          Expanded(
              child: FutureBuilder(
                  future: getKonfOutbound(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text(snapshot.data!.data.list.namaKurikulum),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Pilih Matakuliah Konversi",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: mainOrange2Color,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
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
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.data.list
                                          .listMataKuliah.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    topRight:
                                                        Radius.circular(16),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(
                                                              0xFF1E3B78)
                                                          .withOpacity(0.1),
                                                      spreadRadius: 5,
                                                      blurRadius: 4,
                                                      offset: const Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.7,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            snapshot
                                                                .data!
                                                                .data
                                                                .list
                                                                .listMataKuliah[
                                                                    index]
                                                                .namaMatakuliah
                                                                .toUpperCase(),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color:
                                                                    mainBlueColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        color: mainOrange2Color,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () {
                                                          _idMatakuliah(snapshot
                                                              .data!
                                                              .data
                                                              .list
                                                              .listMataKuliah[
                                                                  index]
                                                              .idMatakuliah
                                                              .toString());
                                                        },
                                                        child: SizedBox(
                                                          width: 40,
                                                          child: Text(
                                                            "Pilih",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color:
                                                                  mainWhiteColor,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ))
                              ],
                            ),
                          ))
                        ],
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
   Future _idMatakuliah(String idMatakuliah) async {
    SpUtil.putString("id_matakuliah", idMatakuliah);
    Navigator.pushNamed(context, 'detailklsout');
  }
}