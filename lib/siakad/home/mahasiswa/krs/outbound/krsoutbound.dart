// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;
import '../../../../model/krsoutboundmodel.dart';
import '../../../../model/krsoutboundprodimodel.dart';
import '../../../../model/listmkoutboundprodimodel.dart';
import '../../../../settings/constant.dart';

class KrsOutbound extends StatefulWidget {
  const KrsOutbound({super.key});

  @override
  State<KrsOutbound> createState() => _KrsOutboundState();
}

class _KrsOutboundState extends State<KrsOutbound> {
    String? idPT;
  String? idProdi;
  Future<ListMkOutboundProdiModel> getListMkOutboundProdi() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(
        Uri.parse(
            "https://ws.unja.ac.id/api/siakad/pertukaran-pelajar/matakuliah?id_prodi=$idProdi&per_page=100"),
        headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return ListMkOutboundProdiModel.fromJson(data);
    } else {
      return ListMkOutboundProdiModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "KRS Outbound Mahasiswa",
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
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                DropdownSearch<KrsOutboundModel>(
                  mode: Mode.MENU,
                  showSearchBox: true,
                  popupItemBuilder: (context, item, isSelected) => ListTile(
                    title: Text(item.namaPt),
                  ),
                  onChanged: (value) => idPT = value?.uuidPtAsal,
                  dropdownBuilder: (context, selectedItem) =>
                      Text(selectedItem?.namaPt ?? "Pilih Universitas"),
                  onFind: (text) async {
                    var header = {
                      "Authorization": "Bearer ${SpUtil.getString("token")}"
                    };
                    var response = await http.get(
                        Uri.parse(
                            "https://ws.unja.ac.id/api/siakad/pertukaran-pelajar/perguruan-tinggi?nama_pt=&per_page=5000"),
                        headers: header);
                    if (response.statusCode != 200) {
                      return [];
                    }
                    List allData = (json.decode(response.body)
                        as Map<String, dynamic>)["data"]["list"];
                        print(response.body);

                    List<KrsOutboundModel> allPT = [];

                    for (var element in allData) {
                      allPT.add(KrsOutboundModel(
                          uuidPtAsal: element["uuid_pt_asal"],
                          kodePt: element["kode_pt"],
                          namaPt: element["nama_pt"],
                          updatedAt: element["updated_at"],
                          singkatan: element["singkatan"],
                          npsn: element["npsn"],
                          status: element["status"]));
                    }
                    print(allPT);
                    return allPT;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownSearch<KrsOutboundProdiModel>(
                  mode: Mode.MENU,
                  showSearchBox: true,
                  popupItemBuilder: (context, item, isSelected) => ListTile(
                    title: Text(item.namaProdi),
                  ),
                  onChanged: (value) => idProdi = value?.idProdi,
                  dropdownBuilder: (context, selectedItem) => Text(
                      selectedItem?.namaProdi ?? "Pilih Program Studi (Prodi)"),
                  onFind: (text) async {
                    var header = {
                      "Authorization": "Bearer ${SpUtil.getString("token")}"
                    };
                    var response = await http.get(
                        Uri.parse(
                            "https://ws.unja.ac.id/api/siakad/pertukaran-pelajar/prodi?id_pt=$idPT&per_page=500"),
                        headers: header);
                    if (response.statusCode != 200) {
                      return [];
                    }
                    List allData = (json.decode(response.body)
                        as Map<String, dynamic>)["data"]["list"];

                    List<KrsOutboundProdiModel> allProdi = [];

                    for (var element in allData) {
                      allProdi.add(KrsOutboundProdiModel(
                          idProdi: element["id_prodi"],
                          kodeProdi: element["kode_prodi"],
                          namaProdi: element["nama_prodi"],
                          idJenjangPendidikan: element["id_jenjang_pendidikan"],
                          namaJenjangPendidikan:
                              element["nama_jenjang_pendidikan"]));
                    }
                    return allProdi;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    getListMkOutboundProdi();
                    setState(() {});
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: mainOrangeColor),
                    child: Text(
                      "Tampilkan Matakuliah Konversi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: mainWhiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Stack(
                  children: [
                    Positioned(
                        child: FutureBuilder<ListMkOutboundProdiModel>(
                            future: getListMkOutboundProdi(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.data.list.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xFF1E3B78)
                                                            .withOpacity(0.1),
                                                    spreadRadius: 5,
                                                    blurRadius: 4,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data!
                                                              .data
                                                              .list[index]
                                                              .namaMatakuliah
                                                              .toUpperCase(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              color:
                                                                  mainBlueColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        // Text("Prodi : ${snapshot
                                                        //     .data!
                                                        //     .data
                                                        //     .list[index]
                                                        //     .prodi
                                                        //     .namaProdi}"),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: mainOrange2Color,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        _idMatakuliah(snapshot
                                                            .data!
                                                            .data
                                                            .list[index]
                                                            .idMatakuliah
                                                            .toString());
                                                      },
                                                      child: SizedBox(
                                                        width: 40,
                                                        child: Text(
                                                          "Pilih",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color:
                                                                mainWhiteColor,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _idMatakuliah(String idMatakuliah) async {
    SpUtil.putString("id_mk_asal", idMatakuliah);
    Navigator.pushNamed(context, 'kurikulumout');
  }
}