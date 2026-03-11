import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'kelompok_page.dart';
import 'kalkulator_page.dart';
import 'bilangan_page.dart';
import 'jumlah_field_page.dart';
import 'stopwatch_page.dart';
import 'piramid_page.dart';
import '../widgets/menu_card.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, required this.username});

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  String getInitials() {
    if (username.isEmpty) return "U";
    List<String> nameParts = username.split(' ');
    return nameParts.length > 1
        ? (nameParts[0][0] + nameParts[1][0]).toUpperCase()
        : username[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Group Data',
        'icon': Icons.layers_outlined,
        'color': const Color(0xFF4C2C64),
        'page': const KelompokPage(),
      },
      {
        'title': 'Calculator',
        'icon': Icons.calculate_outlined,
        'color': const Color(0xFFAD64DD),
        'page': const KalkulatorPage(),
      },
      {
        'title': 'Number Check',
        'icon': Icons.data_usage_rounded,
        'color': const Color(0xFF5856D6),
        'page': const BilanganPage(),
      },
      {
        'title': 'Sum Fields',
        'icon': Icons.functions_rounded,
        'color': const Color(0xFFFF2D55),
        'page': const JumlahFieldPage(),
      },
      {
        'title': 'Stopwatch',
        'icon': Icons.timer_outlined,
        'color': const Color(0xFFFF9500),
        'page': const StopwatchPage(),
      },
      {
        'title': 'Geometry',
        'icon': Icons.vignette_outlined,
        'color': const Color(0xFF34C759),
        'page': const PiramidPage(),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F9FB,
      ), // Warna putih keabuan yang lebih clean
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // HEADER AREA
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Profile Avatar dengan Border Halus
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFAD64DD).withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: const Color(0xFF0E0637),
                          child: Text(
                            getInitials(),
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Logout Button Minimalis
                      IconButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        ),
                        icon: const Icon(
                          Icons.logout_rounded,
                          color: Color(0xFF0E0637),
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "${getGreeting()},",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Text(
                    username.isNotEmpty ? username : "Randra Ferdian",
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF0E0637),
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // FEATURED SECTION (Stats or Quote ala Apple Health)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4C2C64), Color(0xFFAD64DD)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4C2C64).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Siap untuk eksplorasi?",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Pilih salah satu menu di bawah untuk mulai bekerja.",
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // MENU SECTION HEADER
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tools & Workspace",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0E0637),
                    ),
                  ),
                  const Icon(Icons.tune_rounded, size: 20, color: Colors.grey),
                ],
              ),
            ),
          ),

          // GRID MENU (Custom Styled)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = menuItems[index];
                return _buildModernMenuCard(context, item);
              }, childCount: menuItems.length),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  // Widget kartu menu yang lebih berkelas
  Widget _buildModernMenuCard(BuildContext context, Map<String, dynamic> item) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => item['page']),
      ),
      borderRadius: BorderRadius.circular(28),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: (item['color'] as Color).withOpacity(
                0.12,
              ), // Shadow warna sesuai icon
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (item['color'] as Color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(item['icon'], color: item['color'], size: 30),
            ),
            const SizedBox(height: 16),
            Text(
              item['title'],
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0E0637),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
