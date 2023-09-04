import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';
import '../../model/arsipberitaacaramodel.dart';
import '../../../siakad/settings/constant.dart';

class ArsipBeritaAcara extends StatefulWidget {
  const ArsipBeritaAcara({super.key});

  @override
  State<ArsipBeritaAcara> createState() => _ArsipBeritaAcaraState();
}

class _ArsipBeritaAcaraState extends State<ArsipBeritaAcara> {
  Future<ArsipBeritaAcaraModel> getArsipBeritaAcaraData() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(arsipberitaacara), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return ArsipBeritaAcaraModel.fromJson(data);
    } else {
      return ArsipBeritaAcaraModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Arsip Berita Acara",
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
                future: getArsipBeritaAcaraData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.data;
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                          itemCount: data.list.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
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
                                    child: Column(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: mainBlueColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "No. Surat : ${data.list[index].nomorSurat}",
                                                style: TextStyle(
                                                  color: mainWhiteColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                data.list[index].namaMahasiswa,
                                                style: TextStyle(
                                                  color: mainWhiteColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                data.list[index].noMhs,
                                                style: TextStyle(
                                                  color: mainWhiteColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(data.list[index].textJabatan),
                                        Text(data.list[index].tanggal
                                            .toString()),
                                        Text(data.list[index].namaSeminar),
                                        Text(data.list[index].textBelumDiisi),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
