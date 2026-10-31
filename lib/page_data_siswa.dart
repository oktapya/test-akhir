import 'package:flutter/material.dart';
import 'server/server.dart';
import 'page_tambah.dart';
import 'page_edit.dart';
import 'page_login.dart';

class PageDataSiswa extends StatefulWidget {
  const PageDataSiswa({super.key});

  @override
  State<PageDataSiswa> createState() => _PageDataSiswaState();
}

class _PageDataSiswaState extends State<PageDataSiswa> {
  List<dynamic> dataSiswa = [];
  bool loading = true;
  String? pesanError;

  @override
  void initState() {
    super.initState();
    ambilData();
  }

  Future<void> ambilData() async {
    setState(() {
      loading = true;
      pesanError = null;
    });

    try {
      final hasil = await SiswaServer.ambilData();

      if (!mounted) return;

      setState(() {
        dataSiswa = hasil;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
        pesanError = e.toString();
      });
    }
  }

  Future<void> tambahSiswa() async {
    final hasil = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => const PageTambahSiswa(),
      ),
    );

    if (hasil == true) {
      await ambilData();
    }
  }

  Future<void> editSiswa(Map<String, dynamic> siswa) async {
    final hasil = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => PageEditSiswa(siswa: siswa),
      ),
    );

    if (hasil == true) {
      await ambilData();
    }
  }

  Future<void> hapusSiswa(Map<String, dynamic> siswa) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Hapus Data Siswa'),
        content: Text(
          'Yakin ingin menghapus ${siswa['nama_lengkap']}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (konfirmasi != true) return;

    try {
      await SiswaServer.hapusData(siswa['id']);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data siswa berhasil dihapus'),
          backgroundColor: Colors.green,
        ),
      );

      await ambilData();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> logout() async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Logout'),
        content: const Text(
          'Apakah kamu yakin ingin keluar dari aplikasi?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF648ED0),
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (konfirmasi != true || !mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const PageLogin(),
      ),
          (route) => false,
    );
  }

  Widget informasi(IconData icon, String teks) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 19,
            color: const Color(0xFF648ED0),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              teks,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF596779),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget kartuSiswa(Map<String, dynamic> siswa) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEAF0FA),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3EDFF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 30,
                  color: Color(0xFF527CC3),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      siswa['nama_lengkap']?.toString() ??
                          'Tanpa Nama',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF304D78),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'NIPD: ${siswa['nipd'] ?? '-'}',
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Menu titik tiga untuk Edit dan Hapus
              PopupMenuButton<String>(
                tooltip: 'Pilihan data',
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Color(0xFF527CC3),
                  size: 27,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onSelected: (pilihan) {
                  if (pilihan == 'edit') {
                    editSiswa(
                      Map<String, dynamic>.from(siswa),
                    );
                  } else if (pilihan == 'hapus') {
                    hapusSiswa(siswa);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          color: Color(0xFF527CC3),
                        ),
                        SizedBox(width: 12),
                        Text('Edit Data'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'hapus',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        SizedBox(width: 12),
                        Text('Hapus Data'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 28),
          informasi(
            Icons.wc_outlined,
            siswa['jenis_kelamin']?.toString() ?? '-',
          ),
          informasi(
            Icons.location_on_outlined,
            siswa['alamat']?.toString() ?? '-',
          ),
          informasi(
            Icons.school_outlined,
            'Kelas ${siswa['kelas'] ?? '-'}'
                ' • ${siswa['jurusan'] ?? '-'}',
          ),
        ],
      ),
    );
  }

  Widget headerData() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21),
      margin: const EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFE5EEFF),
            Color(0xFFF0F5FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Siswa',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF304D78),
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Kelola seluruh data siswa di sini.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF526987),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.groups_rounded,
                size: 48,
                color: Color(0xFF527CC3),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.people_alt_outlined,
                        color: Color(0xFF527CC3),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          '${dataSiswa.length} siswa',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF304D78),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: tambahSiswa,
                icon: const Icon(Icons.add, size: 20),
                label: const Text('Tambah Data'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF648ED0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard Siswa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: ambilData,
            tooltip: 'Muat ulang data',
            icon: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(width: 5),
        ],
      ),

      // Tombol Logout di pojok kanan bawah
      floatingActionButton: FloatingActionButton.extended(
        onPressed: logout,
        backgroundColor: const Color(0xFF648ED0),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.logout_rounded),
        label: const Text('Logout'),
      ),

      body: loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : pesanError != null
          ? Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.cloud_off_rounded,
                size: 60,
                color: Colors.blueGrey,
              ),
              const SizedBox(height: 15),
              const Text(
                'Gagal Memuat Data',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                pesanError!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: ambilData,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      )
          : RefreshIndicator(
        onRefresh: ambilData,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            18,
            18,
            18,
            100,
          ),
          children: [
            headerData(),
            const Text(
              'Daftar Siswa',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF304D78),
              ),
            ),
            const SizedBox(height: 14),
            if (dataSiswa.isEmpty)
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.people_outline_rounded,
                      size: 60,
                      color: Color(0xFF8CA5C8),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Belum Ada Data Siswa',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF304D78),
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Tekan Tambah Data untuk '
                          'memasukkan siswa baru.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...dataSiswa.map(
                    (item) => kartuSiswa(
                  Map<String, dynamic>.from(item),
                ),
              ),
          ],
        ),
      ),
    );
  }
}