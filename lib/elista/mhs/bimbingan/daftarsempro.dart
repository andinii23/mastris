import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../../siakad/settings/constant.dart';
import '../../model/mhs/cekkelayakansempromodel.dart';

class DaftarSempro extends StatefulWidget {
  const DaftarSempro({super.key});

  @override
  State<DaftarSempro> createState() => _DaftarSemproState();
}

class _DaftarSemproState extends State<DaftarSempro> {
  Future<CekKelayakanSemproModel> getSempro() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response =
        await http.get(Uri.parse(cekkelayakansempro), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return CekKelayakanSemproModel.fromJson(data);
    } else {
      return CekKelayakanSemproModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mendaftar Seminar Proposal",
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
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              color: mainLBlueColor,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PERHATIAN",
                      style: TextStyle(
                          color: mainWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      "Pendaftaran Seminar Proposal hanya dilakukan jika mahasiswa telah mendapat Persetujuan Mengikuti Seminar Proposal Oleh Dosen Pembimbing Tugas Akhir",
                      style: TextStyle(
                        color: mainWhiteColor,
                        // fontWeight: FontWeight.bold,
                      ),
                    )
                  ]),
            ),
            FutureBuilder(
                future: getSempro(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.data.list.kesimpulan.toString() == "1") {
                      return Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          color: Colors.green,
                          child: Text(
                            "Daftar Sempro",
                            style: TextStyle(
                              color: mainWhiteColor,
                              // fontWeight: FontWeight.bold,
                            ),
                          ));
                    } else {
                      return const Text(
                          "");
                    }
                  } else {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      color: Colors.red,
                      child: Text(
                        "Belum memenuhi syarat atau tahapan untuk mendaftar seminar proposal",
                        style: TextStyle(
                          color: mainWhiteColor,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
