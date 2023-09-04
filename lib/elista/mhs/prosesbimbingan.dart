import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';
import '../model/mhs/prosesbimbinganmodel.dart';
import '../../siakad/settings/constant.dart';

class ProsesBimbingan extends StatefulWidget {
  const ProsesBimbingan({super.key});

  @override
  State<ProsesBimbingan> createState() => _ProsesBimbinganState();
}

class _ProsesBimbinganState extends State<ProsesBimbingan> {
  Future<ProsesBimbinganModel> getProsesBimbingan() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(prosesbimbingan), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return ProsesBimbinganModel.fromJson(data);
    } else {
      return ProsesBimbinganModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Proses Bimbingan",
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
            FutureBuilder(
                future: getProsesBimbingan(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.data;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              thickness: 2,
                            ),
                            Text(
                              "Step",
                              style: TextStyle(
                                color: mainBlueColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.list.listStepDilewati.length,
                                itemBuilder: (context, index) {
                                  var dproses = data.list.listStepDilewati[index];
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8),
                                                  child: Text(
                                                    dproses.namaStep,
                                                    style: TextStyle(
                                                      color: mainOrange2Color,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Keterangan",
                                                  style: TextStyle(
                                                    color: mainBlueColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(dproses.keterangan),
                                                const Divider(
                                                  thickness: 2,
                                                ),
                                                Text(
                                                  "Tanggal",
                                                  style: TextStyle(
                                                    color: mainBlueColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                    "${dproses.tanggal} ${dproses.jam}"),
                                                const Divider(
                                                  thickness: 2,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Lama Hari",
                                                          style: TextStyle(
                                                            color:
                                                                mainBlueColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(dproses.lamaHari
                                                            .toString()),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Total Hari",
                                                          style: TextStyle(
                                                            color:
                                                                mainBlueColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(dproses
                                                            .lamaHariKeseluruhan
                                                            .toString()),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 2,
                                      ),
                                    ],
                                  );
                                })
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
