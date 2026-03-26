import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  // MENGGUNAKAN CLASS STOPWATCH BAWAAN DART UNTUK AKURASI TINGGI
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  List<String> laps = [];

  void _start() {
    if (_stopwatch.isRunning) return;

    _stopwatch.start();
    // Timer di sini hanya bertugas me-refresh UI, bukan menghitung angka
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void _stop() {
    if (!_stopwatch.isRunning) {
      _reset();
      return;
    }
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {});
  }

  void _reset() {
    _stopwatch.stop();
    _stopwatch.reset();
    _timer?.cancel();
    setState(() {
      laps = [];
    });
  }

  final Duration _initialTime = const Duration(
    hours: 00,
    minutes: 00,
    seconds: 00,
  );

  void _recordLap() {
    if (_stopwatch.isRunning) {
      setState(() {
        laps.insert(0, _formatTime(_stopwatch.elapsed + _initialTime));
      });
    }
  }

  // Format waktu yang lebih efisien
  String _formatTime(Duration duration) {
    final int ms = duration.inMilliseconds;
    int hundreds = (ms / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String h = hours.toString().padLeft(2, '0');
    String m = (minutes % 60).toString().padLeft(2, '0');
    String s = (seconds % 60).toString().padLeft(2, '0');
    String msStr = (hundreds % 100).toString().padLeft(2, '0');

    return "$h:$m:$s.$msStr";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              "Stopwatch",
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
                children: [
                  // CARD TIMER UTAMA
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 60,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4C2C64), Color(0xFF2C184B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4C2C64).withOpacity(0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _stopwatch.isRunning
                                    ? Icons.timer_outlined
                                    : Icons.timer_off_outlined,
                                color: _stopwatch.isRunning
                                    ? const Color(0xFFAD64DD)
                                    : Colors.white54,
                                size: 14,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _stopwatch.isRunning ? "RUNNING" : "PAUSED",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          _formatTime(_stopwatch.elapsed + _initialTime),
                          style: GoogleFonts.inter(
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontFeatures: [const FontFeature.tabularFigures()],
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // KONTROL BUTTONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildControlButton(
                        icon: Icons.refresh_rounded,
                        color: Colors.grey.shade400,
                        onTap: _reset,
                        isOutlined: true,
                      ),
                      GestureDetector(
                        onTap: _stopwatch.isRunning ? _stop : _start,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: _stopwatch.isRunning
                                ? const Color(0xFFAD64DD)
                                : const Color(0xFF4C2C64),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    (_stopwatch.isRunning
                                            ? const Color(0xFFAD64DD)
                                            : const Color(0xFF4C2C64))
                                        .withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Icon(
                            _stopwatch.isRunning
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      _buildControlButton(
                        icon: Icons.flag_outlined,
                        color: Colors.grey.shade400,
                        onTap: _recordLap,
                        isOutlined: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          if (laps.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lap ${laps.length - index}",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF4C2C64),
                          ),
                        ),
                        Text(
                          laps[index],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0E0637),
                            fontFeatures: [const FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  );
                }, childCount: laps.length),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isOutlined = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: isOutlined ? Colors.transparent : color,
          shape: BoxShape.circle,
          border: isOutlined
              ? Border.all(color: Colors.grey.shade300, width: 2)
              : null,
        ),
        child: Icon(
          icon,
          color: isOutlined ? const Color(0xFF4C2C64) : Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
