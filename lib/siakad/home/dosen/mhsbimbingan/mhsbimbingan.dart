// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_final_fields

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mastrisunja/siakad/home/dosen/mhsbimbingan/mhskrs.dart';
import 'package:sp_util/sp_util.dart';
import '../../../model/mhsbimbinganmodel.dart';
import '../../../model/semester/ketsemmodel.dart';
import '../../../settings/constant.dart';

class MhsBimbingan extends StatefulWidget {
  const MhsBimbingan({super.key});

  @override
  State<MhsBimbingan> createState() => _MhsBimbinganState();
}

class _MhsBimbinganState extends State<MhsBimbingan> {
  TextEditingController _searchController = TextEditingController();
  int jumlahStatus1 = 0;
  int jumlahStatus2 = 0;
  int jumlahStatus3 = 0;
  int jumlahStatus4 = 0;
  String selectedStatus = "";

  Future<KetSemesterModel> getSem() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(semester), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return KetSemesterModel.fromJson(data);
    } else {
      return KetSemesterModel.fromJson(data);
    }
  }

  Future<MhsBimbinganModel> getHomeDosenData() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(mhs_bimbingan), headers: header);
    var data = jsonDecode(response.body.toString());
    // Reset nilai jumlah status sebelum perhitungan ulang
    jumlahStatus1 = 0;
    jumlahStatus2 = 0;
    jumlahStatus3 = 0;
    jumlahStatus4 = 0;
    if (response.statusCode == 200) {
      // print(response.body);
      MhsBimbinganModel dataModel = MhsBimbinganModel.fromJson(data);

      for (var item in dataModel.data.list) {
        String statusKrs = item.statusKrs.toString();

        if (statusKrs == "1") {
          jumlahStatus1++;
        } else if (statusKrs == "2") {
          jumlahStatus2++;
        } else if (statusKrs == "3") {
          jumlahStatus3++;
        } else if (statusKrs.toString() == "null") {
          jumlahStatus4++;
        }
      }
      if (selectedStatus.isNotEmpty) {
        dataModel.data.list = dataModel.data.list
            .where((item) => item.statusKrs.toString() == selectedStatus)
            .toList();
      }
      return dataModel;
    } else {
      return MhsBimbinganModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mahasiswa Bimbingan",
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
            //   Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) {
            //   return const HomeDosen();
            // }));
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: FutureBuilder(
                future: getSem(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "KRS Mahasiswa Semester : ${snapshot.data!.data.list[0].semesterText}",
                      style: TextStyle(
                          color: mainOrange2Color,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    );
                  } else {
                    return const Text("");
                  }
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: FutureBuilder(
                  future: getHomeDosenData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1=menunggu, 2=acc, 3=ditolak, null=belum mengajukan
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              "Status KRS:",
                              style: TextStyle(
                                  color: mainBlueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 160,
                                          child: Text(
                                            "Menunggu Persetujuan",
                                            style: TextStyle(
                                                color: mainBlueColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          ": $jumlahStatus1",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: mainBlueColor,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 160,
                                          child: Text(
                                            "ACC",
                                            style: TextStyle(
                                                color: mainBlueColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          ": $jumlahStatus2",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: mainBlueColor,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 160,
                                          child: Text(
                                            "Ditolak",
                                            style: TextStyle(
                                                color: mainBlueColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          ": $jumlahStatus3",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: mainBlueColor,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 160,
                                          child: Text(
                                            "Belum Mengajukan",
                                            style: TextStyle(
                                                color: mainBlueColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          ": $jumlahStatus4",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: mainBlueColor,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Filter Data",
                                  style: TextStyle(
                                      color: mainBlueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 241, 240, 240),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    value: selectedStatus,
                                    hint: Text(
                                      "Pilih Status",
                                      style: TextStyle(color: mainBlackColor),
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedStatus = newValue!;
                                      });
                                    },
                                    items: <String>["", "1", "2", "3", "null"]
                                        .map<DropdownMenuItem<String>>(
                                      (String value) {
                                        String displayText = "Semua";
                                        if (value == "1") {
                                          displayText = "Menunggu";
                                        } else if (value == "2") {
                                          displayText = "ACC";
                                        } else if (value == "3") {
                                          displayText = "Ditolak";
                                        } else if (value == "null") {
                                          displayText = "Belum Mengajukan";
                                        }

                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: SizedBox(
                                              width: 160,
                                              child: Text(
                                                displayText,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: mainBlackColor),
                                              )),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cari Mahasiswa",
                                  style: TextStyle(
                                      color: mainBlueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 50,
                                  child: TextField(
                                    controller: _searchController,
                                    onChanged: (value) {
                                      setState(() {
                                        // Perform filtering based on the search input
                                        selectedStatus =
                                            ""; // Reset the selected status
                                      });
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(16),
                              child: ListView.builder(
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.data.list.length,
                                  itemBuilder: (context, index) {
                                    // Filter data based on search input
                                    bool matchesSearch = snapshot
                                        .data!.data.list[index].namaMahasiswa
                                        .toLowerCase()
                                        .contains(_searchController.text
                                            .toLowerCase());

                                    if (!matchesSearch) {
                                      return const SizedBox
                                          .shrink(); // Hide items that don't match the search
                                    }
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Divider(
                                          color: mainBlackColor,
                                          thickness: 1,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .data
                                                        .list[index]
                                                        .namaMahasiswa,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            mainOrange2Color),
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .data
                                                        .list[index]
                                                        .noMahasiswa,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: mainBlueColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Status Mahasiswa",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            mainOrange2Color),
                                                  ),
                                                  if (snapshot
                                                          .data!
                                                          .data
                                                          .list[index]
                                                          .idStatusMahasiswa
                                                          .toString() ==
                                                      "A")
                                                    (Text(
                                                      "Aktif",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: mainBlueColor),
                                                    )),
                                                ],
                                              ),
                                            ),
                                            if (snapshot.data!.data.list[index]
                                                    .statusKrs
                                                    .toString() ==
                                                "1")
                                              (InkWell(
                                                onTap: () {
                                                  _krsMhs(snapshot.data!.data
                                                      .list[index].idMhsPt
                                                      .toString());
                                                },
                                                child: Container(
                                                  width: 60,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    "Menunggu Persetujuan",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: mainBlackColor),
                                                  ),
                                                ),
                                              )),
                                            if (snapshot.data!.data.list[index]
                                                    .statusKrs
                                                    .toString() ==
                                                "2")
                                              (InkWell(
                                                onTap: () {
                                                  _krsMhs(snapshot.data!.data
                                                      .list[index].idMhsPt
                                                      .toString());
                                                },
                                                child: Container(
                                                  width: 60,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    "Telah ACC",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: mainWhiteColor),
                                                  ),
                                                ),
                                              )),
                                            if (snapshot.data!.data.list[index]
                                                    .statusKrs
                                                    .toString() ==
                                                "3")
                                              (InkWell(
                                                onTap: () {
                                                  _krsMhs(snapshot.data!.data
                                                      .list[index].idMhsPt
                                                      .toString());
                                                },
                                                child: Container(
                                                  width: 60,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    "Ditolak",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: mainWhiteColor),
                                                  ),
                                                ),
                                              )),
                                            if (snapshot.data!.data.list[index]
                                                    .statusKrs ==
                                                null)
                                              (InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  width: 60,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    "Belum Mengajukan",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: mainWhiteColor,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })),
        ],
      ),
    );
  }

  Future _krsMhs(String idMhsPt) async {
    SpUtil.putString("id_mhs_pt", idMhsPt);
    // Navigator.pushNamed(context, 'mhskrsdosen');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return const MhsKrsDosen();
      }));
  }
}
