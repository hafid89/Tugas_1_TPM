import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HitungUmurPage extends StatefulWidget {
  const HitungUmurPage({super.key});

  @override
  State<HitungUmurPage> createState() => _HitungUmurPageState();
}

class _HitungUmurPageState extends State<HitungUmurPage> {
  DateTime? _birthDate;

  Map<String, int> calculateAge(DateTime birth) {
    DateTime now = DateTime.now();
    Duration diff = now.difference(birth);

    int years = now.year - birth.year;
    int months = now.month - birth.month;
    int days = now.day - birth.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(now.year, now.month, 0).day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    return {
      'years': years,
      'months': months,
      'days': days,
      'hours': diff.inHours % 24,
      'minutes': diff.inMinutes % 60,
    };
  }

  @override
  Widget build(BuildContext context) {
    var age = _birthDate != null ? calculateAge(_birthDate!) : null;

    return Scaffold(
      backgroundColor: const Color(
        0xFFF4F5F6,
      ), // Sesuai tema scaffold di main.dart
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // AppBar Modern dengan Gradient
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
              "Hitung Umur",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w900,
                letterSpacing: -1.5,
                color: const Color(0xFF0E0637),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel("Tanggal Lahir"),
                  const SizedBox(height: 12),
                  _buildModernDatePicker(),

                  const SizedBox(height: 32),

                  if (age != null) ...[
                    _buildSectionLabel("Hasil Perhitungan"),
                    const SizedBox(height: 16),
                    _buildHeroAgeCard(age),
                    const SizedBox(height: 24),
                    _buildDetailGrid(age),
                  ] else ...[
                    const SizedBox(height: 60),
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.cake_outlined,
                            size: 80,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Belum ada data.\nSilakan pilih tanggal lahir Anda.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: Colors.blueGrey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.blueGrey,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildModernDatePicker() {
    String formattedDate = _birthDate != null
        ? DateFormat('dd MMMM yyyy', 'id_ID').format(_birthDate!)
        : "Pilih Tanggal Lahir";

    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _birthDate ?? DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
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
        if (picked != null) setState(() => _birthDate = picked);
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF4C2C64).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cake_rounded,
                color: Color(0xFF4C2C64),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status",
                    style: GoogleFonts.inter(fontSize: 11, color: Colors.grey),
                  ),
                  Text(
                    formattedDate,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0E0637),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.edit_calendar_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroAgeCard(Map<String, int> age) {
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
          Text(
            "Umur Anda saat ini",
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.7),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "${age['years']}",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Tahun",
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            "${age['months']} Bulan ${age['days']} Hari",
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailGrid(Map<String, int> age) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.3,
      children: [
        _buildInfoCard(
          "Total Jam",
          "${age['hours']}",
          Icons.timer_rounded,
          const Color(0xFFAD64DD),
        ),
        _buildInfoCard(
          "Total Menit",
          "${age['minutes']}",
          Icons.history_toggle_off_rounded,
          const Color(0xFF5856D6),
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0E0637),
            ),
          ),
        ],
      ),
    );
  }
}
