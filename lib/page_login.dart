
import 'package:flutter/material.dart';
import 'page_data_siswa.dart';
import 'server/server.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;
  bool isLoading = false;

  final Color biru = const Color(0xFF4263A8);
  final Color ungu = const Color(0xFF7964C8);
  final Color background = const Color(0xFFE8E9FF);

  Future<void> masuk() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan password harus diisi!'),
          backgroundColor: Color(0xFFE05260),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      bool berhasil = await SiswaServer.login(
        emailController.text.trim(),
        passwordController.text,
      );

      if (!mounted) return;

      if (berhasil) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PageDataSiswa(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email atau password salah!'),
            backgroundColor: Color(0xFFE05260),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal menghubungi server!'),
          backgroundColor: Color(0xFFE05260),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF5378C9),
              Color(0xFF7163C8),
              Color(0xFF9678D8),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2DFFF),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Icon(
                        Icons.school_rounded,
                        size: 48,
                        color: biru,
                      ),
                    ),

                    const SizedBox(height: 22),

                    const Text(
                      'SISWA APP',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Sistem Informasi Data Siswa',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFF0EDFF),
                      ),
                    ),

                    const SizedBox(height: 35),

                    Container(
                      padding: const EdgeInsets.all(27),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0EEFF),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: const Color(0xFFD6D0FF),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF302B70)
                                .withValues(alpha: 0.22),
                            blurRadius: 25,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selamat Datang!',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF303B70),
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Silakan masuk untuk melanjutkan.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF686A98),
                            ),
                          ),

                          const SizedBox(height: 28),

                          const Text(
                            'Email',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(0xFF384777),
                            ),
                          ),

                          const SizedBox(height: 9),

                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Masukkan email',
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Color(0xFF536FC0),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFDDE5FF),
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 17),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Color(0xFFC4D1FF),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: biru,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 21),

                          const Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(0xFF384777),
                            ),
                          ),

                          const SizedBox(height: 9),

                          TextField(
                            controller: passwordController,
                            obscureText: !passwordVisible,
                            decoration: InputDecoration(
                              hintText: 'Masukkan password',
                              prefixIcon: const Icon(
                                Icons.lock_outline_rounded,
                                color: Color(0xFF536FC0),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: const Color(0xFF536FC0),
                                ),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFDDE5FF),
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 17),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Color(0xFFC4D1FF),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: biru,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : masuk,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: biru,
                                foregroundColor: Colors.white,
                                elevation: 4,
                                shadowColor:
                                biru.withValues(alpha: 0.35),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : const Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Masuk Sekarang',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_forward_rounded),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Center(
                            child: Text(
                              'SISWA APP • DATA MANAGEMENT',
                              style: TextStyle(
                                fontSize: 10,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF7776A7),
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
          ),
        ),
      ),
    );
  }
}
