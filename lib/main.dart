// ignore_for_file: use_build_context_synchronously, unused_import, avoid_print

import 'dart:io';
import 'package:change_app_package_name/change_app_package_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mastrisunja/elista/developpage.dart';
import 'package:mastrisunja/siakad/home/berita/beritaunja.dart';
import 'package:mastrisunja/siakad/home/berita/detailberita.dart';
import 'package:mastrisunja/siakad/home/berita/homepage.dart';
import 'package:mastrisunja/siakad/home/dosen/chat/chat.dart';
import 'package:mastrisunja/siakad/home/dosen/chat/chatdosen.dart';
import 'package:mastrisunja/siakad/home/dosen/chat/listchatmhs.dart';
import 'package:mastrisunja/siakad/home/dosen/homedosen.dart';
import 'package:mastrisunja/siakad/home/dosen/mhsbimbingan/mhsbimbingan.dart';
import 'package:mastrisunja/siakad/home/dosen/mhsbimbingan/mhskrs.dart';
import 'package:mastrisunja/siakad/home/dosen/mkajar/detailmkajar.dart';
import 'package:mastrisunja/siakad/home/dosen/mkajar/mkajar.dart';
import 'package:mastrisunja/siakad/home/dosen/monitorkuliah/detailmonitor.dart';
import 'package:mastrisunja/siakad/home/dosen/monitorkuliah/editmonitor.dart';
import 'package:mastrisunja/siakad/home/dosen/monitorkuliah/monitorkuliah.dart';
import 'package:mastrisunja/siakad/home/dosen/monitorkuliah/monitorperkelas.dart';
import 'package:mastrisunja/siakad/home/dosen/monitorkuliah/tambahmonitor.dart';
import 'package:mastrisunja/siakad/home/gantipassword.dart';
import 'package:mastrisunja/siakad/home/gerbang.dart';
import 'package:mastrisunja/siakad/home/login.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/chat/chatmhs.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/homemhs.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/khs/khs.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/krs/inbound/dafmkinbound.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/krs/inbound/detailklsinbound.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/krs/inbound/listklsinbound.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/krs/krs.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/krs/outbound/detailklsoutbound.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/krs/outbound/krsoutbound.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/krs/outbound/kurikulumoutbound.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/krs/reguler/detailklskrs.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/krs/reguler/krskelasreguler.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/krs/reguler/listkelaskrs.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/kurikulum/detailkurikulum.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/kurikulum/kurikulum.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/navbar.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/presensi/detailpresensi.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/presensi/presensi.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/riwayatregis.dart';
import 'package:mastrisunja/siakad/home/mahasiswa/tagihan.dart';
import 'package:mastrisunja/siakad/home/welcomepage.dart';

import 'package:sp_util/sp_util.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the background message here
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel? channel;

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title

      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigation to page
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mastris Unja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: (SpUtil.getBool('isLogin'))! ? 'homepage' : 'splash',
      routes: {
        'splash': (context) => const MySplash(),
        'welcome': (context) => const WelcomePage(),
        'gerbangpage': (context) => const GerbangPage(),
        'beritaunja': (context) => const BeritaUnja(),
        'detailberita': (context) => const DetailBerita(),
        'login': (context) => const LoginPage(),
        'homepage': (context) => const HomePage(),
        'homemhs': (context) => const HomeMhs(),
        'homedosen': (context) => const HomeDosen(),
        'navbar': (context) => const Navbar(),
        'riwayatregis': (context) => const RiwayatregistrasiPage(),
        'tagihanmhs': (context) => const TagihanMhs(),
        'kurikulummhs': (context) => const KurikulumMhs(),
        'detailkur': (context) => const DetailKurikulumMhs(),
        'chatmhs': (context) => const ChatMhs(),
        'presensimhs': (context) => const PresesnsiMhs(),
        'detailpresensi': (context) => const DetailPresensiMhs(),
        'khsmhs': (context) => const KhsMhs(),
        'krsmhs': (context) => const KrsMhs(),
        'krsklsreguler': (context) => const KrsKelasReguler(),
        'listklskrs': (context) => const ListKelasKrs(),
        'detailklskrs': (context) => const DetailKlsKrs(),
        'mkinbound': (context) => const MkInboundPage(),
        'listklsinb': (context) => const ListKlsInbound(),
        'detailklsinb': (context) => const DetailKlsInbound(),
        'krsout': (context) => const KrsOutbound(),
        'kurikulumout': (context) => const KurikulumOutbound(),
        'detailklsout': (context) => const DetailKlsOutbound(),
        'mhsbimbingan': (context) => const MhsBimbingan(),
        'mhskrsdosen': (context) => const MhsKrsDosen(),
        'chatdosen': (context) => const ChatDosen(),
        'chat': (context) => const ChatPageDosen(),
        'chatmhsbim': (context) => const ChatMhsBimbingan(),
        'mkajar': (context) => const MkAjar(),
        'detailmkajar': (context) => const DetailMkAjar(),
        'monitorkuliah': (context) => const MonitoringKuliah(),
        'monitorperkelas': (context) => const MonitorPerkelas(),
        'detailmonitor': (context) => const DetailMonitorKuliah(),
        'tambahmonitor': (context) => const TambahPertemuan(),
        'editmonitor': (context) => const EditMonitoringKuliah(),
        'gantipass': (context) => const GantiPassword(),
        'develop': (context) => const DevelopPage(),
      },
    );
  }
}

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    super.initState();
    _loadSplashScreen();
  }

  Future<void> _loadSplashScreen() async {
    await Future.delayed(
        const Duration(seconds: 3)); // Tampilkan splash screen selama 3 detik

    // Pindah ke halaman utama setelah splash screen selesai
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadSplashScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Tampilkan gambar splash screen selama splash screen
          return Scaffold(
            body: Center(
              child: Image.asset(
                'assets/img/logo silver.png', // Ganti dengan path gambar Anda
                width: 200, // Ganti ukuran gambar sesuai keinginan
                height: 200, // Ganti ukuran gambar sesuai keinginan
              ),
            ),
          );
        } else {
          // Jika proses Future sudah selesai, pindah ke halaman utama
          return const WelcomePage();
        }
      },
    );
  }
}
