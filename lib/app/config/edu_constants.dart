import 'dart:ui';

import 'package:flutter/material.dart';

Color whiteColor = Color(0xffffffff);
Color greyColor = Color(0xffE7F8EF);
Color greenColor = Color(0xff34A853);
Color greendarkColor = Color(0xff024102);
Color blueColor = Color.fromARGB(255, 77, 59, 236);
Color redColor = Color.fromARGB(255, 255, 0, 0);

class Constants {
  static const storageKey = "";
  static const login = "Login";
  static const phoneHint = "(+62)812";
  static const phoneLabelText = "Phone number";
  static const resendText = "Kirim ulang OTP";
  static const sendOtpText = "Send OTP";
  static const otpFieldText = "Masukan kode OTP";
  static const greeting = "Assalamualaikum, Orang tua/wali";
  static const gradeText = "kelas";
  static const periodText = "Tahun ajaran";

  static const List<String> itemDesc = [
    'Biaya Sekolah',
    'Kehadiran',
    'Progress',
    'Nilai Ujian',
    'eRapor',
    'Tugas',
    'Jadwal Pelajaran',
    'Lembar Komunikasi',
    'Pengumuman'
  ];

  static const List<IconData> iconMenu = [
    Icons.account_balance_wallet,
    Icons.alarm,
    Icons.bar_chart,
    Icons.book,
    Icons.school,
    Icons.task,
    Icons.calendar_month,
    Icons.chat_bubble,
    Icons.volume_up
  ];
}
