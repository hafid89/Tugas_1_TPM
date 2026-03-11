import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Our Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Menggunakan Inter sebagai font utama sesuai permintaan
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        // Menggunakan warna background dari referensi gambar (#f4f5f6)
        scaffoldBackgroundColor: const Color(0xFFF4F5F6), 
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4C2C64), // Deep Purple dari referensi
          primary: const Color(0xFF4C2C64),
          secondary: const Color(0xFFAD64DD), // Accent Purple
        ),
      ),
      home: const LoginPage(),
    );
  }
}