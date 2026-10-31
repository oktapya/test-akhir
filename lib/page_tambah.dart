import 'package:flutter/material.dart';
import 'server/server.dart';

class PageTambahSiswa extends StatefulWidget {
  const PageTambahSiswa({super.key});

  @override
  State<PageTambahSiswa> createState() => _PageTambahSiswaState();
}

class _PageTambahSiswaState extends State<PageTambahSiswa> {
  final formKey = GlobalKey<FormState>();

  final nipdController = TextEditingController();
  final namaController = TextEditingController();
  final alamatController = TextEditingController();
  final kelasController = TextEditingController();
  final jurusanController = TextEditingController();

  String jenisKelamin = 'Laki-laki';
  bool menyimpan = false;

  @override
  void dispose() {
    nipdController.dispose();
    namaController.dispose();
    alamatController.dispose();
    kelasController.dispose();
    jurusanController.dispose();
    super.dispose();
  }

  Future<void> simpanData() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      menyimpan = true;
    });

    try {
      await SiswaServer.tambahData({
        'nipd': nipdController.text.trim(),
        'nama_lengkap': namaController.text.trim(),
        'jenis_kelamin': jenisKelamin,
        'alamat': alamatController.text.trim(),
        'kelas': kelasController.text.trim(),
        'jurusan': jurusanController.text.trim(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data siswa berhasil ditambahkan'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menambahkan data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          menyimpan = false;
        });
      }
    }
  }

  Widget kolomInput({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF648ED0)),
          filled: true,
          fillColor: const Color(0xFFF5F8FE),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label wajib diisi';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Siswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 25),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3EDFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person_add_alt_1_rounded,
                      size: 40,
                      color: Color(0xFF527CC3),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Tambah Data Siswa',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF304D78),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Lengkapi informasi siswa di bawah ini.',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
              kolomInput(
                label: 'NIPD',
                controller: nipdController,
                icon: Icons.badge_outlined,
              ),
              kolomInput(
                label: 'Nama Lengkap',
                controller: namaController,
                icon: Icons.person_outline,
              ),
              DropdownButtonFormField<String>(
                value: jenisKelamin,
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                  prefixIcon: const Icon(
                    Icons.wc_outlined,
                    color: Color(0xFF648ED0),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F8FE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Laki-laki',
                    child: Text('Laki-laki'),
                  ),
                  DropdownMenuItem(
                    value: 'Perempuan',
                    child: Text('Perempuan'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      jenisKelamin = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 17),
              kolomInput(
                label: 'Alamat',
                controller: alamatController,
                icon: Icons.location_on_outlined,
              ),
              kolomInput(
                label: 'Kelas',
                controller: kelasController,
                icon: Icons.class_outlined,
              ),
              kolomInput(
                label: 'Jurusan',
                controller: jurusanController,
                icon: Icons.school_outlined,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 53,
                child: ElevatedButton.icon(
                  onPressed: menyimpan ? null : simpanData,
                  icon: menyimpan
                      ? const SizedBox(
                    width: 19,
                    height: 19,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(Icons.save_rounded),
                  label: Text(
                    menyimpan ? 'Menyimpan...' : 'Simpan Data Siswa',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF648ED0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}