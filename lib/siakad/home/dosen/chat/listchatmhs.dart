// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';

import '../../../model/mhsbimbinganmodel.dart';
import '../../../settings/constant.dart';


class ChatMhsBimbingan extends StatefulWidget {
  const ChatMhsBimbingan({super.key});

  @override
  State<ChatMhsBimbingan> createState() => _ChatMhsBimbinganState();
}

class _ChatMhsBimbinganState extends State<ChatMhsBimbingan> {
  Future<MhsBimbinganModel> getHomeDosenData() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(mhs_bimbingan), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return MhsBimbinganModel.fromJson(data);
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
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getHomeDosenData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                       padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(color: mainWhiteColor),
                      child: ListView.builder(
                          itemCount: snapshot.data!.data.list.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _chatMhs( snapshot.data!.data.list[index].idMhsPt
                                          .toString(),
                                      snapshot
                                          .data!.data.list[index].namaMahasiswa
                                          .toString());
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  2,
                                          child: Text(
                                            snapshot.data!.data.list[index]
                                                .namaMahasiswa,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: mainBlackColor),
                                          ),
                                        ),
                                        Text(
                                          snapshot
                                              .data!.data.list[index].noMahasiswa,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: mainBlueColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: mainBlackColor,
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                  })),
        ],
      ),
    );
  }

  Future _chatMhs(String idMhsPt, String namaMahasiswa) async {
    SpUtil.putString("id_mhs_pt", idMhsPt);
   SpUtil.putString("nama_mahasiswa", namaMahasiswa);
    Navigator.pushNamed(context, 'chat');
  }
}
