import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';
import '../../model/mhs/agendabimbinganmodel.dart';
import '../../../siakad/settings/constant.dart';

class AgendaBimbingan extends StatefulWidget {
  const AgendaBimbingan({super.key});

  @override
  State<AgendaBimbingan> createState() => _AgendaBimbinganState();
}

class _AgendaBimbinganState extends State<AgendaBimbingan> {
  Future<AgendaBimbinganModel> getAgendaBimData() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(agendabim), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return AgendaBimbinganModel.fromJson(data);
    } else {
      return AgendaBimbinganModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Agenda Bimbingan",
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
                  future: getAgendaBimData(),
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
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            if (data.list[index].gelarDepan
                                                    .toString() ==
                                                "null")
                                              (Text(
                                                "${data.list[index].namaDosen} ${data.list[index].gelarBelakang}",
                                                style: TextStyle(
                                                  color: mainOrange2Color,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                            if (data.list[index].gelarDepan
                                                    .toString() !=
                                                "null")
                                              (Text(
                                                "${data.list[index].gelarDepan} ${data.list[index].namaDosen} ${data.list[index].gelarBelakang}",
                                                style: TextStyle(
                                                  color: mainOrange2Color,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Tanggal",
                                              style: TextStyle(
                                                color: mainBlueColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(data.list[index].tanggal
                                                .toString()),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Jenis Bimbingan",
                                              style: TextStyle(
                                                color: mainBlueColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(data.list[index].jenisBimbingan
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Permasalahan",
                                              style: TextStyle(
                                                color: mainBlueColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(data.list[index].permasalahan
                                                .toString()),
                                            const Divider(
                                              thickness: 2,
                                            ),
                                            Text(
                                              "Solusi",
                                              style: TextStyle(
                                                color: mainBlueColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(data.list[index].solusi
                                                .toString()),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
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
}
