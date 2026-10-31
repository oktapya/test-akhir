import 'package:flutter/material.dart';
import 'page_login.dart';
import 'page_data_siswa.dart';
import 'page_tambah.dart';

class PageDashboard extends StatelessWidget {
  const PageDashboard({super.key});

  static const Color biru = Color(0xFF4263A8);
  static const Color ungu = Color(0xFF7964C8);
  static const Color latar = Color(0xFFE8E9FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latar,
      appBar: AppBar(
        backgroundColor: biru,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Siswa App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const PageLogin(),
                ),
                    (route) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4263A8),
                    Color(0xFF7964C8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.school_rounded,
                    color: Colors.white,
                    size: 38,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Halo, Selamat Datang!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Kelola data siswa dengan mudah dalam satu aplikasi.',
                    style: TextStyle(
                      color: Color(0xFFF0EDFF),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Menu Utama',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF303B70),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Pilih menu yang ingin kamu buka.',
              style: TextStyle(
                color: Color(0xFF626A91),
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: menuCard(
                    icon: Icons.people_alt_rounded,
                    judul: 'Data Siswa',
                    deskripsi: 'Lihat dan kelola data',
                    warna: biru,
                    warnaLatar: const Color(0xFFD7E3FF),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PageDataSiswa(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: menuCard(
                    icon: Icons.person_add_alt_1_rounded,
                    judul: 'Tambah Siswa',
                    deskripsi: 'Masukkan data baru',
                    warna: ungu,
                    warnaLatar: const Color(0xFFE2D9FF),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PageTambahSiswa(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFD6D9FF),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFBFC4FF),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFF4263A8),
                    size: 27,
                  ),
                  SizedBox(width: 13),
                  Expanded(
                    child: Text(
                      'Gunakan menu Data Siswa untuk melihat, mengedit, atau menghapus data yang tersedia.',
                      style: TextStyle(
                        color: Color(0xFF303B70),
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuCard({
    required IconData icon,
    required String judul,
    required String deskripsi,
    required Color warna,
    required Color warnaLatar,
    required VoidCallback onTap,
  }) {
    return Material(
      color: warnaLatar,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 49,
                height: 49,
                decoration: BoxDecoration(
                  color: warna,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 27,
                ),
              ),
              const SizedBox(height: 19),
              Text(
                judul,
                style: const TextStyle(
                  color: Color(0xFF303B70),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                deskripsi,
                style: const TextStyle(
                  color: Color(0xFF626A91),
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Icon(
                Icons.arrow_forward_rounded,
                color: warna,
              ),
            ],
          ),
        ),
      ),
    );
  }
}