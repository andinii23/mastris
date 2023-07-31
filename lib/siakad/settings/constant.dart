// ignore_for_file: prefer_const_constructors, prefer_const_declarations, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:flutter/material.dart';

final mainWhiteColor =  Color(0xffffffff);
final mainLightOrangeColor = Color(0xffFF964A);
final mainOrangeColor = Color(0xffDD5F0E);
final mainBlackColor = Color(0xff404040);
final mainBlueColor = Color(0xFF1E3B78);
final mainOrange2Color = Color(0xffE9561B);

final main_url = "https://ws.unja.ac.id/";
final login_url = main_url + "api/login";
final register = main_url + "api/siakad/registrasi?order_by=id_semester&order_dir=desc";
final home = main_url + "api/siakad/home";
final presensi = main_url + "api/siakad/presensi";
final kurikulum = main_url + "api/siakad/kurikulum-mahasiswa";
final dkurikulum = main_url + "api/siakad/kurikulum-mahasiswa?semester=";
final khs = main_url + "api/siakad/khs";
final dkhs = main_url + "api/siakad/khs?id_semester=";

final krs = main_url + "api/siakad/krs";
final krs_kelas = main_url + "api/siakad/krs/kelas?group_by_matakuliah=1";
final krs_ruang_kelas = main_url + "api/siakad/krs/kelas?id_matakuliah=";
final krs_inbound = main_url + "api/siakad/krs/kelas?kelas_mbkm=1";
final krs_kelas_inbound = main_url + "api/siakad/krs/kelas?id_matakuliah=";
final krs_outbound_pt = main_url + "api/siakad/pertukaran-pelajar/perguruan-tinggi?nama_pt=Universitas Jambi&per_page=10";

final detail_krs_kelas = main_url + "api/siakad/krs/kelas/";
final tagihan = main_url + "api/siakad/tagihan?order_by=waktu_open&order_dir=desc";
final biodata = main_url + "api/siakad/biodata";
final semester = main_url + "api/siakad/semester?order_by=id_semester&order_dir=desc";
final semestermhs = main_url + "api/siakad/semester-mahasiswa?order_by=create_date&order_dir=desc";
final detailpresensi = main_url + "api/siakad/presensi/kelas?id_kelas=";
final matakuliahajar = main_url + "api/siakad/matakuliah-ajar?id_semester=";

final monitorkuliah = main_url + "api/siakad/monitoring-perkuliahan?id_semester=";
final monitorperkelas = main_url + "api/siakad/monitoring-perkuliahan/";
final monitorperkelasdetail = main_url + "api/siakad/monitoring-perkuliahan/detail-pertemuan/";

final ambil_kelas = main_url + "api/siakad/krs";
final ajukan_krs = main_url + "api/siakad/krs/ajukan";
final hapus_kelas = main_url + "api/siakad/krs/delete/";
final mhs_bimbingan = main_url + "api/siakad/bimbingan-akademik";
final krs_mhs_bimbingan = main_url + "api/siakad/bimbingan-akademik/";
final terima_krs = main_url + "api/siakad/bimbingan-akademik/setujui-krs";
final presensi_mhs = main_url + "api/siakad/presensi";
final gantipass = main_url + "api/siakad/user/ubah-password";

final chat = main_url + "api/siakad/konsultasi-akademik/";
final chat_dosen = main_url + "api/siakad/konsultasi-akademik/";

final chatdosen = main_url + "api/siakad/konsultasi-akademik";
final tambahpertemuan = main_url + "api/siakad/monitoring-perkuliahan/";

final detailkrs_kelasoutbound = main_url + "api/siakad/krs/detail-matakuliah-outbound/";
final simpan_kelasoutbound = main_url + "api/siakad/krs/store-mk-pertukaran";
final tambah = main_url + "api/siakad/monitoring-perkuliahan/";

final userId = main_url + "api/siakad/user-info";
final ktm = main_url + "api/siakad/cetak-ktm";

final detailmkajar = main_url + "api/siakad/matakuliah-ajar/";
final fcmtoken = main_url + "api/siakad/fcm-token";
final mhsmonitor = main_url + "api/siakad/monitoring-perkuliahan/detail-pertemuan/";
final cetakkrs = main_url + "api/siakad/krs/cetak";
final cetakkhs = main_url + "api/siakad/khs/cetak";
final cetaktranskip = main_url + "api/siakad/cetak-transkrip";
final versi = main_url + "api/version";

final berita = main_url + "https://unja.ac.id/wp-json/wp/v2/posts";

//elista
final mhsbimelista = main_url + "api/elista/mahasiswa-bimbingan";

