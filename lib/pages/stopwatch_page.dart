import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  int milliseconds = 0;
  Timer? timer;
  bool isRunning = false;

  void start() {
    if (isRunning) return;
    setState(() => isRunning = true);
    timer = Timer.periodic(const Duration(milliseconds: 10), (t) {
      setState(() {
        milliseconds += 10;
      });
    });
  }

  void stop() {
    if (!isRunning) {
      reset();
      return;
    }
    timer?.cancel();
    setState(() => isRunning = false);
  }

  void reset() {
    timer?.cancel();
    setState(() {
      milliseconds = 0;
      isRunning = false;
    });
  }

  String formatTime(int ms) {
    int seconds = ms ~/ 1000;
    int minutes = seconds ~/ 60;
    int hours = minutes ~/ 60;
    int remainingSeconds = seconds % 60;
    int remainingMinutes = minutes % 60;
    int remainingMilliseconds = (ms % 1000) ~/ 10;

    return "${hours.toString().padLeft(2, '0')}:"
        "${remainingMinutes.toString().padLeft(2, '0')}:"
        "${remainingSeconds.toString().padLeft(2, '0')}."
        "${remainingMilliseconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stopwatch"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade100, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    formatTime(milliseconds),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: isRunning ? Colors.green : Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isRunning ? "⏱ BERJALAN" : "⏸ BERHENTI",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton.extended(
                    onPressed: start,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Mulai"),
                    backgroundColor: Colors.green,
                  ),
                  FloatingActionButton.extended(
                    onPressed: stop,
                    icon: const Icon(Icons.pause),
                    label: const Text("Pause"),
                    backgroundColor: Colors.orange,
                  ),
                  FloatingActionButton.extended(
                    onPressed: reset,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Reset"),
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
