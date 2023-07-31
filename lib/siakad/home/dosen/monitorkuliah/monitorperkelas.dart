// ignore_for_file: import_of_legacy_library_into_null_safe, use_build_context_synchronously, avoid_print, prefer_const_declarations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';

import '../../../model/monitorkuliahperkelasmodel.dart';
import '../../../settings/constant.dart';


class MonitorPerkelas extends StatefulWidget {
  const MonitorPerkelas({super.key});

  @override
  State<MonitorPerkelas> createState() => _MonitorPerkelasState();
}

class _MonitorPerkelasState extends State<MonitorPerkelas> {
  String idMonitor = "";
  Future<MonitorKuliahPerkelasModel> getDetailData() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http
        .get(Uri.parse(monitorperkelas + SpUtil.getString("id_kelass")!), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body);
      return MonitorKuliahPerkelasModel.fromJson(data);
    } else {
      return MonitorKuliahPerkelasModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            Navigator.pushNamed(context, 'monitorkuliah');
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: FutureBuilder<MonitorKuliahPerkelasModel>(
                future: getDetailData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data.list.length,
                              itemBuilder: (context, index) {
                                idMonitor = snapshot.data!.data.list[index]
                                    .idMonitoringPerkuliahan
                                    .toString();
                                String tgl =
                                    snapshot.data!.data.list[index].tanggal;
                                DateTime tanggal = DateTime.parse(tgl);
                                DateFormat dateFormat =
                                    DateFormat('dd-MM-yyyy');

                                String tanggalFormatted =
                                    dateFormat.format(tanggal);
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: mainBlueColor,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                              ),
                                            ),
                                            child: Text(
                                              snapshot.data!.data.list[index]
                                                  .materi,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: mainWhiteColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
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
                                                  itemCount: snapshot.data!.data
                                                      .list[index].dosen.length,
                                                  itemBuilder:
                                                      (context, dosen) {
                                                    if (snapshot
                                                            .data!
                                                            .data
                                                            .list[index]
                                                            .dosen[dosen]
                                                            .gelarDepan !=
                                                        null) {
                                                      return Center(
                                                        child: Text(
                                                          "${snapshot.data!.data.list[index].dosen[dosen].gelarDepan.toString()} ${snapshot.data!.data.list[index].dosen[dosen].namaPegawai.toString()} ${snapshot.data!.data.list[index].dosen[dosen].gelarBelakang.toString()}",
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
                                                          "${snapshot.data!.data.list[index].dosen[dosen].namaPegawai.toString()} ${snapshot.data!.data.list[index].dosen[dosen].gelarBelakang.toString()}",
                                                          style: TextStyle(
                                                            color:
                                                                mainBlueColor,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  })
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          // Divider(
                                          //   thickness: 1.5,
                                          //   color: mainBlackColor,
                                          // ),
                                          Text(
                                            "Tanggal : $tanggalFormatted",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: mainBlueColor,
                                              fontSize: 16,
                                            ),
                                          ),

                                          Text(
                                            "Jam : ${snapshot.data!.data.list[index].jamMulai.toString()} - ${snapshot.data!.data.list[index].jamSelesai.toString()}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: mainBlueColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 106,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Hadir",
                                                      style: TextStyle(
                                                          color: mainBlueColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .data
                                                          .list[index]
                                                          .kehadiran
                                                          .hadir
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: mainBlueColor,
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
                                                      "Absen",
                                                      style: TextStyle(
                                                          color: mainBlueColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .data
                                                          .list[index]
                                                          .kehadiran
                                                          .absen
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: mainBlueColor,
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
                                                      "Izin",
                                                      style: TextStyle(
                                                          color: mainBlueColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .data
                                                          .list[index]
                                                          .kehadiran
                                                          .izin
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: mainBlueColor,
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
                                          Divider(
                                            thickness: 1.5,
                                            color: mainBlackColor,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              if (snapshot.data!.data
                                                      .list[index].statusSiremun
                                                      .toString() !=
                                                  "1")
                                                (InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: SizedBox(
                                                              child: Text(
                                                                "Apakah anda yakin akan menghapus pertemuan ini?",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color:
                                                                        mainBlackColor,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                            actions: [
                                                              MaterialButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                  "Batal",
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainBlackColor),
                                                                ),
                                                              ),
                                                              MaterialButton(
                                                                onPressed: () {
                                                                  deleteWithBody(snapshot
                                                                      .data!
                                                                      .data
                                                                      .list[
                                                                          index]
                                                                      .idMonitoringPerkuliahan
                                                                      .toString());
                                                                },
                                                                child: Text(
                                                                  "OK",
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainBlackColor),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.delete,
                                                        color: mainBlueColor,
                                                      ),
                                                      Text(
                                                        "Hapus",
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
                                                )),
                                              InkWell(
                                                onTap: () {
                                                  _editM(
                                                      snapshot
                                                          .data!
                                                          .data
                                                          .list[index]
                                                          .idMonitoringPerkuliahan
                                                          .toString(),
                                                      snapshot.data!.data
                                                          .list[index].idKelas
                                                          .toString(),
                                                      snapshot
                                                          .data!
                                                          .data
                                                          .list[index]
                                                          .statusSiremun
                                                          .toString());
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.edit,
                                                        color: mainBlueColor),
                                                    Text(
                                                      "Edit",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: mainBlueColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  _idMonitor(snapshot
                                                      .data!
                                                      .data
                                                      .list[index]
                                                      .idMonitoringPerkuliahan
                                                      .toString());
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                        FontAwesomeIcons
                                                            .circleInfo,
                                                        color: mainBlueColor),
                                                    Text(
                                                      "Detail",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: mainBlueColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                );
                              }),
                        ),
                        if (snapshot.data!.data.list.length <= 16 &&
                            snapshot.data!.data.list.length != 16)
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: (FloatingActionButton.extended(
                              onPressed: () {
                                _tambahMonitor(idMonitor);
                              },
                              label: const Text('Pertemuan'),
                              icon: const Icon(Icons.add),
                              backgroundColor: mainBlackColor,
                            )),
                          ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Future _idMonitor(String idMonitoringPerkuliahan) async {
    SpUtil.putString("id_monitoring_perkuliahann", idMonitoringPerkuliahan);
    Navigator.pushNamed(context, 'detailmonitor');
  }

  Future _tambahMonitor(String idMonitoringPerkuliahan) async {
    SpUtil.putString("id_monitoring_perkuliahann", idMonitoringPerkuliahan);
    Navigator.pushNamed(context, 'tambahmonitor');
  }

  Future _editM(String idMonitoringPerkuliahan, String idKelas,
      String statusSiremun) async {
    SpUtil.putString("id_monitoring_perkuliahann", idMonitoringPerkuliahan);
    SpUtil.putString("id_kelass", idKelas);
    SpUtil.putString("status_siremun", statusSiremun);
    Navigator.pushNamed(context, 'editmonitor');
  }

  Future<void> deleteWithBody(String idMonitoringPerkuliahan) async {
    final url = 'https://ws.unja.ac.id/api/siakad/monitoring-perkuliahan';

    // Create a map representing the request body
    final requestBody = {
      'id_monitoring_perkuliahan': idMonitoringPerkuliahan,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${SpUtil.getString("token")}',
        'X-HTTP-Method-Override':
            'DELETE', // Specify the intended method as DELETE
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Request was successful
      Navigator.pushNamed(context, 'monitorperkelas');
      print('DELETE request with body succeeded.');
    } else {
      // Request failed
      print(
          'DELETE request with body failed with status code: ${response.statusCode}');
    }
  }
}
