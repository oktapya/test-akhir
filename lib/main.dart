import 'package:flutter/material.dart';
import 'page_login.dart';

void main() {
  runApp(const AplikasiSiswa());
}

class AplikasiSiswa extends StatelessWidget {
  const AplikasiSiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Data Siswa',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF648ED0),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F7FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE6EEFC),
          foregroundColor: Color(0xFF31558C),
          centerTitle: false,
        ),
      ),
      home: const PageLogin(),
    );
  }
}