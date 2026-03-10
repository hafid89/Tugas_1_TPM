import 'package:flutter/material.dart';

class JumlahFieldPage extends StatefulWidget {
  const JumlahFieldPage({super.key});

  @override
  State<JumlahFieldPage> createState() => _JumlahFieldPageState();
}

class _JumlahFieldPageState extends State<JumlahFieldPage> {
  final TextEditingController angka = TextEditingController();
  double total = 0;

  void hitung() {
    if (angka.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Masukkan angka terlebih dahulu")),
      );
      return;
    }

    List<String> data = angka.text.split(RegExp(r'[,\s]+'));

    double sum = 0;
    int count = 0;
    for (var item in data) {
      double? val = double.tryParse(item.trim());
      if (val != null) {
        sum += val;
        count++;
      }
    }

    setState(() {
      total = sum;
    });

    if (count == 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("⚠️ Tidak ada angka valid")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jumlah Total Angka dalam Satu Field"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red.shade100, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: angka,
                        decoration: const InputDecoration(
                          labelText: "Masukkan angka dipisah koma atau spasi",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.format_list_numbered),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: hitung,
                        icon: const Icon(Icons.calculate),
                        label: const Text("Hitung Total Angka anda"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
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
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Total: $total",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
