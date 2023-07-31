// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sp_util/sp_util.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../model/detailberita.dart';
import '../../settings/constant.dart';

class DetailBerita extends StatefulWidget {
  const DetailBerita({super.key});

  @override
  State<DetailBerita> createState() => _DetailBeritaState();
}

class _DetailBeritaState extends State<DetailBerita> {
  Future<DetailBeritaM> getDetailBeritaM() async {
    var response = await http.get(Uri.parse(
        "https://unja.ac.id/wp-json/wp/v2/posts/${SpUtil.getString("id_berita")}"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body);
      return DetailBeritaM.fromJson(data);
    } else {
      return DetailBeritaM.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "",
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
      body: FutureBuilder(
          future: getDetailBeritaM(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 10, bottom: 10, right: 10),
                      child: Text(
                        snapshot.data!.title.rendered.toString(),
                        style: TextStyle(
                          color: mainBlackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                        left: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "Written By : ${snapshot.data!.yoastHeadJson.twitterMisc.writtenBy}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                   
                  ],
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 90),
                    child: WebView(
                      initialUrl: "about:blank", // Use about:blank initially
                      onWebViewCreated:
                          (WebViewController webViewController) {
                        // Load the HTML content when the WebView is created
                        webViewController.loadUrl(Uri.dataFromString(
                          snapshot.data!.content.rendered.toString(),
                          mimeType: 'text/html',
                          encoding: Encoding.getByName('utf-8'),
                        ).toString());
                      },
                    ),
                  ),
                ]

              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
