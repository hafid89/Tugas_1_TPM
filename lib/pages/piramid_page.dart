import 'package:flutter/material.dart';

class PiramidPage extends StatefulWidget {
  const PiramidPage({super.key});

  @override
  State<PiramidPage> createState() => _PiramidPageState();
}

class _PiramidPageState extends State<PiramidPage> {
  final TextEditingController panjang = TextEditingController();
  final TextEditingController lebar = TextEditingController();
  final TextEditingController tinggi = TextEditingController();

  double luas = 0;
  double volume = 0;

  void hitung() {
    double? p = double.tryParse(panjang.text);
    double? l = double.tryParse(lebar.text);
    double? t = double.tryParse(tinggi.text);

    if (p == null || l == null || t == null) {
      setState(() {
        luas = 0;
        volume = 0;
      });
      return;
    }

    double luasAlas = p * l;

    volume = (1 / 3) * luasAlas * t;
    luas = luasAlas + (2 * (0.5 * p * t)) + (2 * (0.5 * l * t));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hitung Piramid"),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.brown.shade100, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Gambar piramid sederhana
                SizedBox(
                  height: 100,
                  child: CustomPaint(painter: PyramidPainter()),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: panjang,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Panjang Alas",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.straighten),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: lebar,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Lebar Alas",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.straighten),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: tinggi,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Tinggi",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.height),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: hitung,
                          icon: const Icon(Icons.calculate),
                          label: const Text("Hitung"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  color: Colors.amber.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          "Luas Permukaan: ${luas.toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Volume: ${volume.toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom painter untuk menggambar piramid sederhana
class PyramidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    var path = Path();
    // Gambar segitiga (piramid dari samping)
    path.moveTo(size.width * 0.2, size.height * 0.8);
    path.lineTo(size.width * 0.5, size.height * 0.2);
    path.lineTo(size.width * 0.8, size.height * 0.8);
    path.close();
    canvas.drawPath(path, paint);

    // Gambar garis alas
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.8),
      Offset(size.width * 0.8, size.height * 0.8),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
