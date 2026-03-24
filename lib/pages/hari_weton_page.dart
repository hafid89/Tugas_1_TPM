import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HariWetonPage extends StatefulWidget {
  const HariWetonPage({super.key});

  @override
  State<HariWetonPage> createState() => _HariWetonPageState();
}

class _HariWetonPageState extends State<HariWetonPage> {
  DateTime _selectedDate = DateTime.now();

  // Logic tetap sama karena sudah jalan
  String getWeton(DateTime date) {
    final List<String> pasaran = ["Legi", "Pahing", "Pon", "Wage", "Kliwon"];
    DateTime referenceDate = DateTime(2024, 1, 1); // Senin Pahing
    DateTime dateNormalized = DateTime(date.year, date.month, date.day);
    DateTime refNormalized = DateTime(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day,
    );

    int diff = dateNormalized.difference(refNormalized).inDays;
    int index = (diff + 1) % 5;
    if (index < 0) index += 5;
    return pasaran[index];
  }

  @override
  Widget build(BuildContext context) {
    String hari = DateFormat('EEEE', 'id_ID').format(_selectedDate);
    String weton = getWeton(_selectedDate);
    String tglFormatted = DateFormat(
      'dd MMMM yyyy',
      'id_ID',
    ).format(_selectedDate);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F6),
      body: CustomScrollView(
        slivers: [
          // Custom Sleek AppBar
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
              "Hari & Weton",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w900,
                letterSpacing: -1.5,
                color: const Color(0xFF0E0637),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pilih Tanggal",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildModernDatePicker(tglFormatted),

                  const SizedBox(height: 40),

                  Text(
                    "Hasil Konversi",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Utama Result Card (Hero Card)
                  _buildHeroResultCard(hari, weton),

                  const SizedBox(height: 24),

                  // Detail Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          "Hari Masehi",
                          hari,
                          Icons.calendar_today_rounded,
                          const Color(0xFF4C2C64),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInfoCard(
                          "Pasaran Jawa",
                          weton,
                          Icons.auto_awesome_rounded,
                          const Color(0xFFAD64DD),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Input Picker yang lebih Modern
  Widget _buildModernDatePicker(String formattedDate) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF4C2C64),
                  onPrimary: Colors.white,
                  onSurface: Color(0xFF0E0637),
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) setState(() => _selectedDate = picked);
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF4C2C64).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.event_note_rounded,
                color: Color(0xFF4C2C64),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tanggal Terpilih",
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  formattedDate,
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0E0637),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Hero Card untuk menampilkan hasil utama dengan Gradient
  Widget _buildHeroResultCard(String hari, String weton) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0E0637), Color(0xFF4C2C64)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0E0637).withOpacity(0.2),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            "$hari $weton",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(),
          ),
        ],
      ),
    );
  }

  // Small Info Cards
  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0E0637),
            ),
          ),
        ],
      ),
    );
  }
}
