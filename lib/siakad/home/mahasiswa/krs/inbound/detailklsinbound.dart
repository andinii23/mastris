// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';

import '../../../../model/detailkrsinboundmodel.dart';
import '../../../../settings/constant.dart';
class DetailKlsInbound extends StatefulWidget {
  const DetailKlsInbound({super.key});

  @override
  State<DetailKlsInbound> createState() => _DetailKlsInboundState();
}

class _DetailKlsInboundState extends State<DetailKlsInbound> {
  @override
  Widget build(BuildContext context) {
     Future<DetailKelasInboundModel> getDetailKelas() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http
        .get(Uri.parse(detail_krs_kelas + SpUtil.getString("id_kelas")!), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return DetailKelasInboundModel.fromJson(data);
    } else {
      return DetailKelasInboundModel.fromJson(data);
    }
  }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detail Kelas Mahasiswa",
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
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
                future: getDetailKelas(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1E3B78).withOpacity(0.1),
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
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
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
                                    "Dosen",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: mainWhiteColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount:
                                          snapshot.data!.data.list.dosen.length,
                                      itemBuilder: (context, dsn) {
                                        return Column(
                                          children: [
                                            Text(
                                              "${snapshot.data!.data.list.dosen[dsn].namaDosen} ${snapshot.data!.data.list.dosen[dsn].gelarBelakang}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: mainWhiteColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapshot.data!.data.list.matakuliah.kodeMatakuliah
                                  .toString(),
                              style: TextStyle(
                                color: mainOrange2Color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data!.data.list.matakuliah.namaMatakuliah
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: mainBlueColor),
                            ),
                            const Divider(
                              thickness: 2,
                            ),
                            Text(
                              "Jumlah Mahasiswa Kontrak : ${snapshot.data!.data.list.jumlahMahasiswaKontrak}",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: mainBlueColor),
                            ),
                            Text(
                              "Kelas : ${snapshot.data!.data.list.kodeKelas}",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: mainBlueColor),
                            ),
                            Text(
                              "Semester : ${snapshot.data!.data.list.semester}",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: mainBlueColor),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (snapshot.data!.data.list.kesimpulan
                                    .toString() ==
                                "1")
                              (GestureDetector(
                                onTap: () {
                                  _kontrakMk();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: mainOrange2Color,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    "Ambil Kelas",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: mainWhiteColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                            if (snapshot.data!.data.list.kesimpulan
                                    .toString() ==
                                "0")
                              (Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: mainOrange2Color,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  "Mk Tidak Tersedia",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: mainWhiteColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  Future _kontrakMk() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.post(Uri.parse(ambil_kelas), headers: header, body: {
      "id_kelas": SpUtil.getString("id_kelas"),
      "status_kontrak": "B",
    });
    if (response.statusCode == 200) {
      print(response.body);
      Navigator.pushNamed(context, 'krsmhs');
    } else {
      print("gagal menambahkan kelas");
      var body = jsonDecode(response.body);
      print(body["error_message"]);
    }
  }
}