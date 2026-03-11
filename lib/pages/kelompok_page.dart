import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KelompokPage extends StatelessWidget {
  const KelompokPage({super.key});

  // LOGIC TETAP: Data anggota kelompok
  final List<Map<String, String>> anggota = const [
    {'nama': 'Hafid Dwi Saputra', 'nim': '123230051', 'role': 'Anggota'},
    {
      'nama': 'Vincentius Erwan Wijaya',
      'nim': '123230025',
      'role': 'Ketua Kelompok',
    },
    {'nama': 'Randra Ferdian Saputra', 'nim': '123230014', 'role': 'Anggota'},
    {'nama': 'Taura Kaka Arissa', 'nim': '123230217', 'role': 'Anggota'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF4F5F6,
      ), // Background bersih dari referensi
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
              "Data Kelompok",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w900,
                letterSpacing: -1.5,
                color: const Color(0xFF0E0637),
              ),
            ),
          ),

          // Header Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4C2C64), Color(0xFF2C184B)],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Anggota Kelompok",
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      "Teknologi Pemrograman Mobile",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Divider Label
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                "MEMBERS LIST",
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: const Color(0xFF4C2C64).withOpacity(0.5),
                ),
              ),
            ),
          ),

          // List Anggota
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final member = anggota[index];
                final bool isLeader = member['role'] == 'Ketua Kelompok';

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: _getColorForIndex(index).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            color: _getColorForIndex(index),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      member['nama']!,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0E0637),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          "NIM • ${member['nim']}",
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isLeader
                                ? const Color(0xFFAD64DD).withOpacity(0.1)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            member['role']!.toUpperCase(),
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                              color: isLeader
                                  ? const Color(0xFF4C2C64)
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: isLeader
                        ? const Icon(
                            Icons.stars_rounded,
                            color: Color(0xFFAD64DD),
                            size: 28,
                          )
                        : Icon(
                            Icons.person_outline_rounded,
                            color: Colors.grey.shade300,
                          ),
                  ),
                );
              }, childCount: anggota.length),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  // LOGIC TETAP: Namun dengan palet warna yang lebih "Apple-ish"
  Color _getColorForIndex(int index) {
    List<Color> colors = [
      const Color(0xFF007AFF), // Blue
      const Color(0xFF34C759), // Green
      const Color(0xFFFF9500), // Orange
      const Color(0xFFAF52DE), // Purple
      const Color(0xFFFF2D55), // Pink
    ];
    return colors[index % colors.length];
  }
}
