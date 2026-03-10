import 'package:flutter/material.dart';

class BilanganPage extends StatefulWidget {
  const BilanganPage({super.key});

  @override
  State<BilanganPage> createState() => _BilanganPageState();
}

class _BilanganPageState extends State<BilanganPage> {
  final TextEditingController angka = TextEditingController();
  String hasil = "";

  bool isPrima(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  void cek() {
    int? n = int.tryParse(angka.text);
    if (n == null) {
      setState(() {
        hasil = "Masukkan angka valid";
      });
      return;
    }

    String jenis = n % 2 == 0 ? "Genap" : "Ganjil";
    String prima = isPrima(n) ? "Bilangan Prima" : "Bukan Prima";

    setState(() {
      hasil = "$jenis\n$prima";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cek Jenis Bilangan Anda"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade100, Colors.white],
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
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Masukkan Angka",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.input),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: cek,
                        icon: const Icon(Icons.check_circle),
                        label: const Text("Cek"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (hasil.isNotEmpty)
                Card(
                  color: Colors.amber.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      hasil,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
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
