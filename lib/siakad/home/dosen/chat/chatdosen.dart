// ignore_for_file: import_of_legacy_library_into_null_safe, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:http/http.dart' as http;

import '../../../model/listchatdosenmodel.dart';
import '../../../settings/constant.dart';


class ChatDosen extends StatefulWidget {
  const ChatDosen({super.key});

  @override
  State<ChatDosen> createState() => _ChatDosenState();
}

class _ChatDosenState extends State<ChatDosen> {
  Future<ListChatDosenModel> getListChat() async {
    var header = {"Authorization": "Bearer ${SpUtil.getString("token")}"};
    var response = await http.get(Uri.parse(chatdosen), headers: header);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // print(response.body);
      return ListChatDosenModel.fromJson(data);
    } else {
      return ListChatDosenModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Chat",
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
                future: getListChat(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: ListView.builder(
                          itemCount: snapshot.data!.data.list.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration:
                                    BoxDecoration(color: mainWhiteColor),
                                child: InkWell(
                                  onTap: () {
                                    _idMhs(
                                        snapshot.data!.data.list[index].idMhsPt
                                            .toString(),
                                        snapshot.data!.data.list[index]
                                            .namaMahasiswa
                                            .toString());
                                  },
                                  child: Card(
                                      elevation: 0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // ignore: unnecessary_null_comparison
                                          if (snapshot.data!.data.list[index]
                                                  .lastMessage !=
                                              null)
                                            (Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                    height: 10,
                                                  ),
                                                Text(
                                                  snapshot.data!.data
                                                      .list[index].namaMahasiswa
                                                      .toUpperCase()
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .data
                                                      .list[index]
                                                      .lastMessage!
                                                      .pesan
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                    height: 10,
                                                  ),
                                                const Divider(
                                                  thickness: 1,
                                                )
                                              ],
                                            )),
                                          if (snapshot.data!.data.list[index]
                                                  .lastMessage ==
                                              null)
                                            (const Text(""))
                                        ],
                                      )),
                                ));
                          }),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child:  const Icon(Icons.message),
        backgroundColor: mainBlueColor,
        onPressed: () {
          Navigator.pushNamed(context, 'chatmhsbim');
        },
      ),
    );
  }

  Future _idMhs(String idMhsPt, String namaMahasiswa) async {
    SpUtil.putString("id_mhs_pt", idMhsPt);
    SpUtil.putString("nama_mahasiswa", namaMahasiswa);
    Navigator.pushNamed(context, 'chat');
  }
}
