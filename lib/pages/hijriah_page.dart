import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class HijriahPage extends StatefulWidget {
  const HijriahPage({super.key});

  @override
  State<HijriahPage> createState() => _HijriahPageState();
}

class _HijriahPageState extends State<HijriahPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var hDate = HijriCalendar.fromDate(_selectedDate);
    String tglMasehi = DateFormat(
      'dd MMMM yyyy',
      'id_ID',
    ).format(_selectedDate);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F6),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
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
              "Tanggal Hijriah",
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
                  Text(
                    "Pilih Tanggal Masehi",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDateSelector(tglMasehi),

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

                  // Hero Result Card
                  _buildHijriResultCard(hDate),

                  const SizedBox(height: 24),

                  // Info Tambahan (Simple Card)
                  _buildInfoDetailCard(hDate),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk memilih tanggal dengan desain kartu modern
  Widget _buildDateSelector(String formattedDate) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(1930),
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
                Icons.calendar_month_rounded,
                color: Color(0xFF4C2C64),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Masehi Terpilih",
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
            const Icon(Icons.edit_note_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Hero Card dengan desain islami modern
  Widget _buildHijriResultCard(HijriCalendar hDate) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0E0637), Color(0xFF4C2C64)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0E0637).withOpacity(0.25),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.mosque_rounded, color: Colors.white24, size: 48),
          const SizedBox(height: 16),
          Text(
            hDate.toFormat("dd MMMM yyyy"),
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Hijriah",
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.6),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Detail tambahan bulan dan tahun
  Widget _buildInfoDetailCard(HijriCalendar hDate) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFAD64DD).withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDetailItem("Bulan ke-", hDate.hMonth.toString()),
          Container(height: 30, width: 1, color: Colors.grey.withOpacity(0.2)),
          _buildDetailItem("Tahun", "${hDate.hYear} H"),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12, color: Colors.blueGrey),
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
    );
  }
}
