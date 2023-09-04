import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';
import '../../settings/constant.dart';

class BeritaUnja extends StatefulWidget {
  const BeritaUnja({super.key});

  @override
  State<BeritaUnja> createState() => _BeritaUnjaState();
}

class _BeritaUnjaState extends State<BeritaUnja> {
  List _data = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Berita UNJA",
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
      body: SizedBox(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _data.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 10),
                child: InkWell(
                    onTap: () {
                      _detailBerita(_data[index]["id"].toString());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1E3B78).withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 4,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                            color: mainWhiteColor),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 150,
                              height: 100,
                              child: Image(
                                  image: NetworkImage(_data[index]
                                              ["yoast_head_json"]["og_image"][0]
                                          ["url"]
                                      .toString()),
                                  fit: BoxFit.cover),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      _data[index]["title"]["rendered"]
                                          .toString(),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  if (_data[index]["yoast_head_json"]
                                              ["description"]
                                          .toString() !=
                                      "null")
                                    (Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        _data[index]["yoast_head_json"]
                                                ["description"]
                                            .toString(),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              );
            }),
      ),
    );
  }

  Future _getData() async {
    try {
      final response =
          await http.get(Uri.parse("https://unja.ac.id/wp-json/wp/v2/posts"));
      if (response.statusCode == 200) {
        // print(response.body);
        final data = json.decode(response.body);
        setState(() {
          _data = data;
        });
        // print("Data : $_data");
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future _detailBerita(String idBerita) async {
    SpUtil.putString("id_berita", idBerita);
    Navigator.pushNamed(context, 'detailberita');
  }
}
