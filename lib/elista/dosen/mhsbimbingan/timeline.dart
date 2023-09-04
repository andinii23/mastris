import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mastrisunja/elista/model/timelinemodel.dart';
import 'package:sp_util/sp_util.dart';
import '../../../siakad/settings/constant.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  Future<TimelineModel> getTimelineElista() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(timelinelista), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return TimelineModel.fromJson(data);
    } else {
      return TimelineModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Timeline Mahasiswa Bimbingan",
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
                  future: getTimelineElista(),
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          data.list[index].nama,
                                          style: TextStyle(
                                            color: mainOrange2Color,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          data.list[index].nim,
                                          style: TextStyle(
                                            color: mainBlueColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 2,
                                        ),
                                        Text(
                                          "Tanggal Pengajuan",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: mainBlueColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${data.list[index].tanggalPengajuan}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: mainBlackColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Status Ajuan",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: mainBlueColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (data.list[index].statusAjuan
                                                .toString() ==
                                            "1")
                                          (Text("Disetujui"))
                                      ],
                                    ),
                                  ),
                                ),
                              );
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
}
