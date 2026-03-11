import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Pastikan package ini ada di pubspec.yaml
import 'pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan warna background elegan dari referensi gambar
      backgroundColor: const Color(0xFFF4F5F6),
      body: Stack(
        children: [
          // Dekorasi Lingkaran Halus (Aksen Premium)
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFFAD64DD).withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo dengan BoxShadow lembut
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4C2C64), Color(0xFFAD64DD)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(32), // Squircle ala iOS
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4C2C64).withOpacity(0.2),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons
                        .blur_on_rounded, // Menggunakan icon yang sama dengan LoginPage baru
                    color: Colors.white,
                    size: 60,
                  ),
                ),

                const SizedBox(height: 32),

                // Nama App dengan Font Inter Black
                Text(
                  'Our Apps',
                  style: GoogleFonts.inter(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.5,
                    color: const Color(0xFF0E0637), // Navy Purple gelap
                  ),
                ),

                const SizedBox(height: 12),

                // Subtitle Modern
                Text(
                  'Premium & Minimalist',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.blueGrey.shade400,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 60),

                // Loading Indicator yang lebih ramping
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFAD64DD),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Versi App di bagian bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Text(
                'VERSION 1.0.0',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
