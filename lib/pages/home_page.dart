import 'package:flutter/material.dart';
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

  // Fungsi untuk mendapatkan sapaan berdasarkan waktu
  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "Selamat Pagi Cuy";
    } else if (hour < 17) {
      return "Selamat Sore Bro";
    } else {
      return "Infokan Mabar";
    }
  }

  // Fungsi untuk mendapatkan inisial username
  String getInitials() {
    if (username.isEmpty) return "U";

    List<String> nameParts = username.split(' ');
    if (nameParts.length > 1) {
      return (nameParts[0][0] + nameParts[1][0]).toUpperCase();
    } else {
      return username[0].toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Data menu items
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Data Kelompok Kami',
        'icon': Icons.group,
        'color': Colors.orange,
        'page': const KelompokPage(),
      },
      {
        'title': 'Kalkulator',
        'icon': Icons.calculate,
        'color': Colors.green,
        'page': const KalkulatorPage(),
      },
      {
        'title': 'Cek Bilangan Anda',
        'icon': Icons.numbers,
        'color': Colors.purple,
        'page': const BilanganPage(),
      },
      {
        'title': 'Jumlah Angka Dalam Satu Field',
        'icon': Icons.summarize,
        'color': Colors.red,
        'page': const JumlahFieldPage(),
      },
      {
        'title': 'Stopwatch',
        'icon': Icons.timer,
        'color': Colors.teal,
        'page': const StopwatchPage(),
      },
      {
        'title': 'Hitung Luas & Volume Piramid',
        'icon': Icons.architecture,
        'color': Colors.brown,
        'page': const PiramidPage(),
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND GAMBAR
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/background.png',
                ), // Ganti dengan nama file background Anda
                fit: BoxFit.cover,
              ),
            ),
          ),

          // LAPISAN GELAP (agar konten lebih terbaca)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withValues(alpha: 0.3), // gelapkan 30%
          ),

          // CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AppBar custom (karena kita tidak pakai AppBar bawaan)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Menu Aplikasi",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black54,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.logout, color: Colors.white),
                            onPressed: () {
                              // Logout ke halaman login
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Welcome message dengan username (dengan background semi transparan)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          radius: 25,
                          child: Text(
                            getInitials(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getGreeting(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                username.isNotEmpty ? username : "User",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "What would you like to do today?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      shadows: [
                        const Shadow(
                          blurRadius: 5,
                          color: Colors.black54,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Grid Menu (dengan card yang sudah ada)
                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.85,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        final item = menuItems[index];
                        return MenuCard(
                          title: item['title'],
                          icon: item['icon'],
                          color: item['color'],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => item['page'],
                              ),
                            );
                          },
                        );
                      },
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
}
