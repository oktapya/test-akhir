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
  static const Color biru = Color(0xFF4263A8);
  static const Color ungu = Color(0xFF7964C8);
  static const Color latar = Color(0xFFE8E9FF);

  List<dynamic> daftarSiswa = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    ambilData();
  }

  Future<void> ambilData() async {
    setState(() {
      loading = true;
    });

    try {
      final hasil = await SiswaServer.ambilData();

      if (!mounted) return;

      setState(() {
        daftarSiswa = hasil;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengambil data siswa: $e'),
          backgroundColor: const Color(0xFFD94355),
        ),
      );
    }
  }

  Future<void> hapusSiswa(dynamic id) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF0EEFF),
        title: const Text(
          'Hapus Data?',
          style: TextStyle(
            color: Color(0xFF303B70),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Data siswa ini akan dihapus.',
          style: TextStyle(color: Color(0xFF626A91)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD94355),
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
      await SiswaServer.hapusData(id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data siswa berhasil dihapus'),
          backgroundColor: biru,
        ),
      );

      await ambilData();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menghapus data: $e'),
          backgroundColor: const Color(0xFFD94355),
        ),
      );
    }
  }

  Future<void> bukaTambah() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PageTambahSiswa(),
      ),
    );

    if (mounted) {
      ambilData();
    }
  }

  Future<void> bukaEdit(Map<String, dynamic> siswa) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageEditSiswa(siswa: siswa),
      ),
    );

    if (mounted) {
      ambilData();
    }
  }

  Future<void> logout() async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF0EEFF),
        title: const Text('Keluar dari aplikasi?'),
        content: const Text('Kamu akan kembali ke halaman login.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: biru,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (konfirmasi == true && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const PageLogin(),
        ),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latar,
      appBar: AppBar(
        backgroundColor: biru,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Data Siswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: ambilData,
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Muat ulang',
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ambilData,
        color: biru,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 100),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4263A8),
                    Color(0xFF7964C8),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Kelola Siswa',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Data siswa tersimpan di sistem.',
                          style: TextStyle(
                            color: Color(0xFFF0EDFF),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF304B8A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${daftarSiswa.length} Data Siswa',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.groups_rounded,
                    size: 65,
                    color: Color(0xFFDCD7FF),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Daftar Siswa',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF303B70),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: bukaTambah,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ungu,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  icon: const Icon(Icons.add_rounded, size: 20),
                  label: const Text(
                    'Tambah',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (loading)
              const Padding(
                padding: EdgeInsets.all(45),
                child: Center(
                  child: CircularProgressIndicator(color: biru),
                ),
              )
            else if (daftarSiswa.isEmpty)
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFFD7E3FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.people_outline_rounded,
                      size: 55,
                      color: biru,
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Belum Ada Data Siswa',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF303B70),
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Tekan tombol Tambah untuk memasukkan data baru.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF626A91),
                      ),
                    ),
                  ],
                ),
              )
            else
              ...daftarSiswa.asMap().entries.map((entry) {
                final index = entry.key;
                final siswa = Map<String, dynamic>.from(entry.value as Map);

                final warnaKartu = index.isEven
                    ? const Color(0xFFDCE6FF)
                    : const Color(0xFFE4DDFF);

                final nama = siswa['nama_lengkap']?.toString() ?? '-';
                final nipd = siswa['nipd']?.toString() ?? '-';
                final kelas = siswa['kelas']?.toString() ?? '-';
                final jurusan = siswa['jurusan']?.toString() ?? '-';

                return Container(
                  margin: const EdgeInsets.only(bottom: 13),
                  decoration: BoxDecoration(
                    color: warnaKartu,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(
                      color: index.isEven
                          ? const Color(0xFFC1D0FF)
                          : const Color(0xFFCEC1FF),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 16, 8, 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: index.isEven ? biru : ungu,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                            size: 29,
                          ),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nama,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF303B70),
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                'NIPD  $nipd',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF505B87),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Kelas $kelas • $jurusan',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF505B87),
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.more_vert_rounded,
                            color: Color(0xFF303B70),
                          ),
                          color: const Color(0xFFF0EEFF),
                          onSelected: (pilihan) {
                            if (pilihan == 'edit') {
                              bukaEdit(siswa);
                            } else if (pilihan == 'hapus') {
                              hapusSiswa(siswa['id']);
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit_rounded,
                                    color: biru,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Edit Data'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'hapus',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_rounded,
                                    color: Color(0xFFD94355),
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Hapus Data'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: logout,
        backgroundColor: const Color(0xFFD94355),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.logout_rounded),
        label: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}