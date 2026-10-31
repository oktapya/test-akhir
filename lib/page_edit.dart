import 'package:flutter/material.dart';
import 'server/server.dart';

class PageEditSiswa extends StatefulWidget {
  final Map<String, dynamic> siswa;

  const PageEditSiswa({
    super.key,
    required this.siswa,
  });

  @override
  State<PageEditSiswa> createState() => _PageEditSiswaState();
}

class _PageEditSiswaState extends State<PageEditSiswa> {
  final formKey = GlobalKey<FormState>();

  final nipdController = TextEditingController();
  final namaController = TextEditingController();
  final alamatController = TextEditingController();

  String? jenisKelamin;
  String? kelas;
  String? jurusan;

  bool loading = false;

  static const Color biru = Color(0xFF4263A8);
  static const Color ungu = Color(0xFF7964C8);
  static const Color latar = Color(0xFFE8E9FF);

  @override
  void initState() {
    super.initState();

    final jk = widget.siswa['jenis_kelamin']?.toString();

    jenisKelamin = jk == 'L'
        ? 'Laki-laki'
        : jk == 'P'
        ? 'Perempuan'
        : jk;
  }

  @override
  void dispose() {
    nipdController.dispose();
    namaController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  Future<void> simpanPerubahan() async {
    if (!formKey.currentState!.validate()) return;

    if (jenisKelamin == null || kelas == null || jurusan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lengkapi jenis kelamin, kelas, dan jurusan!'),
          backgroundColor: Color(0xFFD94355),
        ),
      );
      return;
    }

    setState(() => loading = true);

    try {
      await SiswaServer.editData(
        widget.siswa['id'],
        {
          'nipd': nipdController.text.trim(),
          'nama_lengkap': namaController.text.trim(),
          'jenis_kelamin': jenisKelamin,
          'alamat': alamatController.text.trim(),
          'kelas': kelas,
          'jurusan': jurusan,
        },
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data siswa berhasil diperbarui!'),
          backgroundColor: biru,
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui data: $e'),
          backgroundColor: const Color(0xFFD94355),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  InputDecoration dekorasi(String label, IconData ikon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(ikon, color: biru),
      filled: true,
      fillColor: const Color(0xFFDDE5FF),
      labelStyle: const TextStyle(
        color: Color(0xFF53618C),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFC4D1FF),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: biru,
          width: 2,
        ),
      ),
    );
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
          'Edit Data Siswa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [biru, ungu],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(21),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.edit_note_rounded,
                      color: Colors.white,
                      size: 45,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Perbarui Data',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            'Ubah informasi siswa sesuai kebutuhan.',
                            style: TextStyle(
                              color: Color(0xFFF0EDFF),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EEFF),
                  borderRadius: BorderRadius.circular(21),
                  border: Border.all(
                    color: const Color(0xFFD2CEFF),
                  ),
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nipdController,
                      decoration: dekorasi(
                        'NIPD',
                        Icons.badge_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'NIPD wajib diisi';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 17),

                    TextFormField(
                      controller: namaController,
                      textCapitalization: TextCapitalization.words,
                      decoration: dekorasi(
                        'Nama Lengkap',
                        Icons.person_outline_rounded,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama lengkap wajib diisi';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 17),

                    DropdownButtonFormField<String>(
                      value: jenisKelamin,
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
                        setState(() {
                          jenisKelamin = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 17),

                    TextFormField(
                      controller: alamatController,
                      maxLines: 3,
                      decoration: dekorasi(
                        'Alamat',
                        Icons.location_on_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Alamat wajib diisi';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 17),

                    DropdownButtonFormField<String>(
                      value: kelas,
                      decoration: dekorasi(
                        'Kelas',
                        Icons.class_outlined,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'X',
                          child: Text('X'),
                        ),
                        DropdownMenuItem(
                          value: 'XI',
                          child: Text('XI'),
                        ),
                        DropdownMenuItem(
                          value: 'XII',
                          child: Text('XII'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => kelas = value);
                      },
                    ),

                    const SizedBox(height: 17),

                    DropdownButtonFormField<String>(
                      value: jurusan,
                      decoration: dekorasi(
                        'Jurusan',
                        Icons.school_outlined,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'RPL',
                          child: Text('Rekayasa Perangkat Lunak (RPL)'),
                        ),
                        DropdownMenuItem(
                          value: 'TKJ',
                          child: Text('Teknik Komputer dan Jaringan (TKJ)'),
                        ),
                        DropdownMenuItem(
                          value: 'AKL',
                          child: Text('Akuntansi (AKL)'),
                        ),
                        DropdownMenuItem(
                          value: 'OTKP',
                          child: Text('OTKP'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => jurusan = value);
                      },
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton.icon(
                        onPressed: loading ? null : simpanPerubahan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: biru,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(0xFF9CAED8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: loading
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Icon(Icons.save_rounded),
                        label: Text(
                          loading ? 'Menyimpan...' : 'Simpan Perubahan',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}