// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../../model/presensimhsmodel.dart';
import '../../../settings/constant.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class PresesnsiMhs extends StatefulWidget {
  const PresesnsiMhs({super.key});

  @override
  State<PresesnsiMhs> createState() => _PresesnsiMhsState();
}

class _PresesnsiMhsState extends State<PresesnsiMhs> {
  Future<PresensiModel> getPresensiData() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(presensi), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return PresensiModel.fromJson(data);
    } else {
      return PresensiModel.fromJson(data);
    }
  }

  Future _qrScanner() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      String? qrdata = await scanner.scan();
      var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
      var response =
          await http.post(Uri.parse(presensi_mhs), headers: header, body: {
        "id_monitoring_perkuliahan": qrdata,
      });
      if (response.statusCode == 200) {
        // print(response.body);
        Navigator.pushNamed(context, 'KrsMhs');
      } else {
        print("gagal presensi");
        var body = jsonDecode(response.body);
        print(body["error_message"]);
      }
    } else {
      var isGrant = await Permission.camera.request();

      if (isGrant.isGranted) {
        String? qrdata = await scanner.scan();
        print(qrdata);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Presensi Mahasiswa",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: mainBlackColor,
                  fontWeight: FontWeight.w700),
            ),
            GestureDetector(
              onTap: () {
                _qrScanner();
              },
              child: Icon(
                FontAwesomeIcons.qrcode,
                color: mainBlackColor,
              ),
            ),
          ],
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
          // Text(qrdata!),
          Expanded(
            child: FutureBuilder<PresensiModel>(
              future: getPresensiData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.data.list.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF1E3B78).withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: mainBlueColor,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                        ),
                                        child: Text(
                                          "${snapshot.data!.data.list[index].matakuliah.kodeMatakuliah.toString()} : ${snapshot.data!.data.list[index].matakuliah.namaMatakuliah.toUpperCase().toString()}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: mainWhiteColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
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
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.data
                                            .list[index].dosen.length,
                                        itemBuilder: (context, dosen) {
                                          if (snapshot.data!.data.list[index]
                                                  .dosen[dosen].gelarDepan !=
                                              null) {
                                            return Center(
                                              child: Text(
                                                "${snapshot.data!.data.list[index].dosen[dosen].gelarDepan.toString()} ${snapshot.data!.data.list[index].dosen[dosen].namaPegawai.toString()} ${snapshot.data!.data.list[index].dosen[dosen].gelarBelakang.toString()}",
                                                style: TextStyle(
                                                  color: mainBlueColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child: Text(
                                                "${snapshot.data!.data.list[index].dosen[dosen].namaPegawai.toString()} ${snapshot.data!.data.list[index].dosen[dosen].gelarBelakang.toString()}",
                                                style: TextStyle(
                                                  color: mainBlueColor,
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
                                    Text(
                                      "Ruang ${snapshot.data!.data.list[index].kodeKelas.toString()}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: mainBlueColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    if (snapshot.data!.data.list[index]
                                            .ruangKuliah.namaRuang
                                            .toString() !=
                                        "null")
                                      (Text(
                                        snapshot.data!.data.list[index]
                                            .ruangKuliah.namaRuang
                                            .toString(),
                                        style: TextStyle(
                                          color: mainBlueColor,
                                          fontSize: 14,
                                        ),
                                      )),
                                    Text(
                                      "Jumlah SKS : ${snapshot.data!.data.list[index].matakuliah.sksTotal.toString()}",
                                      style: TextStyle(
                                        color: mainBlueColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "Jumlah Pertemuan : ${snapshot.data!.data.list[index].jumlahPertemuan.toString()}",
                                      style: TextStyle(
                                        color: mainBlueColor,
                                        fontSize: 14,
                                      ),
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
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 106,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Hari",
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapshot.data!.data.list[index].hari
                                                .toString(),
                                            style: TextStyle(
                                              color: mainOrange2Color,
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
                                                color: mainOrange2Color,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          if (snapshot.data!.data.list[index]
                                                  .jamMulai
                                                  .toString() !=
                                              "null")
                                            (Text(
                                              snapshot.data!.data.list[index]
                                                  .jamMulai
                                                  .toString(),
                                              style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                              ),
                                            )),
                                          if (snapshot.data!.data.list[index]
                                                  .jamMulai
                                                  .toString() ==
                                              "null")
                                            (Text(
                                              "-",
                                              style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                              ),
                                            )),
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
                                                color: mainOrange2Color,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          if (snapshot.data!.data.list[index]
                                                  .jamSelesai
                                                  .toString() !=
                                              "null")
                                            (Text(
                                              snapshot.data!.data.list[index]
                                                  .jamSelesai
                                                  .toString(),
                                              style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                              ),
                                            )),
                                          if (snapshot.data!.data.list[index]
                                                  .jamSelesai
                                                  .toString() ==
                                              "null")
                                            (Text(
                                              "-",
                                              style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 14,
                                              ),
                                            )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
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
                                            "Jumlah Masuk",
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapshot.data!.data.list[index]
                                                .jumlahMasuk
                                                .toString(),
                                            style: TextStyle(
                                              color: mainOrange2Color,
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
                                            "Jumlah Izin",
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapshot.data!.data.list[index]
                                                .jumlahIzin
                                                .toString(),
                                            style: TextStyle(
                                              color: mainOrange2Color,
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
                                            "Jumlah Absen",
                                            style: TextStyle(
                                                color: mainOrange2Color,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapshot.data!.data.list[index]
                                                .jumlahAbsen
                                                .toString(),
                                            style: TextStyle(
                                              color: mainOrange2Color,
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
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: mainOrange2Color,
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            _detailPresensi(snapshot
                                                .data!.data.list[index].idKelas
                                                .toString());
                                          },
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Detail",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: mainWhiteColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: mainWhiteColor,
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
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future _detailPresensi(String idKelas) async {
    SpUtil.putString("id_kelas", idKelas);
    Navigator.pushNamed(context, 'detailpresensi');
  }
}
