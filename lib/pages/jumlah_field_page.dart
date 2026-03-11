import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JumlahFieldPage extends StatefulWidget {
  const JumlahFieldPage({super.key});

  @override
  State<JumlahFieldPage> createState() => _JumlahFieldPageState();
}

class _JumlahFieldPageState extends State<JumlahFieldPage> {
  // LOGIC TETAP SAMA
  final TextEditingController angka = TextEditingController();
  double total = 0;

  void hitung() {
    if (angka.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("⚠️ Masukkan angka terlebih dahulu"),
          backgroundColor: const Color(0xFF4C2C64),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    List<String> data = angka.text.split(RegExp(r'[,\s]+'));

    double sum = 0;
    int count = 0;
    for (var item in data) {
      double? val = double.tryParse(item.trim());
      if (val != null) {
        sum += val;
        count++;
      }
    }

    setState(() {
      total = sum;
    });

    if (count == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("⚠️ Tidak ada angka valid"),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F6), // Background bersih
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // AppBar Modern ala iOS
          SliverAppBar.large(
            backgroundColor: const Color(0xFFF4F5F6),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF4C2C64),
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              "Total Angka",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w900,
                letterSpacing: -1.5,
                color: const Color(0xFF0E0637),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CARD INPUT
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputLabel("MASUKKAN DERET ANGKA"),
                        TextField(
                          controller: angka,
                          maxLines: 3,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: "Contoh: 10, 20, 30 atau 10 20 30",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(
                              Icons.format_list_numbered_rounded,
                              color: Color(0xFFAD64DD),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF4F5F6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.all(20),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // TOMBOL HITUNG
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: hitung,
                            icon: const Icon(Icons.functions_rounded, size: 20),
                            label: const Text(
                              "HITUNG TOTAL",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4C2C64),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // CARD HASIL (Gradient Style)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4C2C64), Color(0xFFAD64DD)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4C2C64).withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "HASIL PENJUMLAHAN",
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          total % 1 == 0
                              ? total.toInt().toString()
                              : total.toStringAsFixed(2),
                          style: GoogleFonts.inter(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
          color: const Color(0xFF4C2C64).withOpacity(0.6),
        ),
      ),
    );
  }
}
