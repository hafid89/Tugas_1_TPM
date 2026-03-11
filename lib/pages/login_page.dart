import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  final List<Map<String, String>> demoUsers = const [
    {'username': 'admin', 'password': 'A123'},
    {'username': 'Hafid', 'password': 'H123'},
  ];

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),

              // Ikon Logo dengan gradasi ungu lembut
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4C2C64), Color(0xFFAD64DD)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.blur_on_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),

              const SizedBox(height: 32),
              const Text(
                "Our Apps",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.5,
                  color: Color(0xFF0E0637), // Navy Purple gelap
                ),
              ),
              const Text(
                "Experience the elegance of simplicity.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 56),

              // INPUT SECTION
              _buildModernInput(
                label: "ACCOUNT ID",
                controller: usernameController,
                hint: "Enter your username",
                icon: Icons.alternate_email_rounded,
              ),
              const SizedBox(height: 28),
              _buildModernInput(
                label: "ACCESS KEY",
                controller: passwordController,
                hint: "••••••••",
                icon: Icons.key_rounded,
                obscure: true,
              ),

              const SizedBox(height: 48),

              // TOMBOL LOGIN (Solid Deep Purple)
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Logic tetap sama
                    String username = usernameController.text.trim();
                    String password = passwordController.text.trim();
                    bool isValid = demoUsers.any(
                      (u) =>
                          u['username'] == username &&
                          u['password'] == password,
                    );

                    if (isValid) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(username: username),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C184B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // DEMO USERS SECTION
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4C2C64).withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "QUICK ACCESS",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        color: Color(0xFFAD64DD),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...demoUsers.map(
                      (user) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          user['username']!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text("Password: ${user['password']}"),
                        trailing: TextButton(
                          onPressed: () {
                            usernameController.text = user['username']!;
                            passwordController.text = user['password']!;
                          },
                          child: const Text("Auto-fill"),
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
    );
  }

  Widget _buildModernInput({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            color: Color(0xFF4C2C64),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            prefixIcon: Icon(icon, color: const Color(0xFFAD64DD), size: 20),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE5E5EA), width: 2),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF4C2C64), width: 2.5),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }
}
