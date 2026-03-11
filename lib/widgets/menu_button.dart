import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        // Efek tekan sedikit mengecil (Haptic-like feel)
        transform: Matrix4.diagonal3Values(
          _isPressed ? 0.98 : 1.0,
          _isPressed ? 0.98 : 1.0,
          1.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              // Shadow mengikuti warna icon agar terlihat premium
              color: widget.color.withOpacity(_isPressed ? 0.05 : 0.12),
              blurRadius: _isPressed ? 10 : 20,
              offset: Offset(0, _isPressed ? 4 : 10),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Ikon dengan background lingkaran halus
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(widget.icon, size: 26, color: widget.color),
            ),
            const SizedBox(width: 20),
            // Judul dengan Inter Font
            Expanded(
              child: Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0E0637), // Navy gelap
                  letterSpacing: -0.3,
                ),
              ),
            ),
            // Indikator panah khas iOS yang lebih modern
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey.shade300,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
