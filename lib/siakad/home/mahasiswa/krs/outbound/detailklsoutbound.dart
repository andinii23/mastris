// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../../../model/detailkrsklsoutboundmodel.dart';
import '../../../../settings/constant.dart';

class DetailKlsOutbound extends StatefulWidget {
  const DetailKlsOutbound({super.key});

  @override
  State<DetailKlsOutbound> createState() => _DetailKlsOutboundState();
}

class _DetailKlsOutboundState extends State<DetailKlsOutbound> {
  @override
  Widget build(BuildContext context) {
    Future<DetailKrsKelasOutboundModel> getDetailKelas() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(
        Uri.parse("$detailkrs_kelasoutbound${SpUtil.getString("id_mk_asal")}/${SpUtil.getString("id_matakuliah")}"),
        headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return DetailKrsKelasOutboundModel.fromJson(data);
    } else {
      return DetailKrsKelasOutboundModel.fromJson(data);
    }
  }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detail Kelas Outbound",
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
              child: FutureBuilder<DetailKrsKelasOutboundModel>(
                  future: getDetailKelas(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
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
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Matakuliah Asal",
                                      style: TextStyle(
                                          color: mainBlueColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${snapshot.data!.data.list.matakuliahAsal.kodeMatakuliah} : ${snapshot.data!.data.list.matakuliahAsal.namaMatakuliah.toUpperCase()}",
                                      style: TextStyle(
                                          color: mainOrange2Color,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        "Program Studi : ${snapshot.data!.data.list.matakuliahAsal.prodi}"),
                                    Text(
                                        "Universitas : ${snapshot.data!.data.list.matakuliahAsal.pt}"),
                                    Text(
                                        "SKS : ${snapshot.data!.data.list.matakuliahAsal.sksTotal}"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(
                                      thickness: 2,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Matakuliah Konversi",
                                      style: TextStyle(
                                          color: mainBlueColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${snapshot.data!.data.list.matakuliahKonversi.kodeMatakuliah} : ${snapshot.data!.data.list.matakuliahKonversi.namaMatakuliah}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: mainOrange2Color,
                                      ),
                                    ),
                                    Text(
                                        "Program Studi : ${snapshot.data!.data.list.matakuliahKonversi.prodi}"),
                                    Text(
                                        "Universitas : ${snapshot.data!.data.list.matakuliahKonversi.pt}"),
                                    Text(
                                        "SKS : ${snapshot.data!.data.list.matakuliahKonversi.sksTotal}"),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _kontrakMk();
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: mainBlueColor,
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
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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

  Future _kontrakMk() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response =
        await http.post(Uri.parse(simpan_kelasoutbound), headers: header, body: {
      "id_matakuliah_konversi": SpUtil.getString("id_matakuliah"),
      "id_matakuliah_asal": SpUtil.getString("id_mk_asal")
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