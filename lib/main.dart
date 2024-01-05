import 'package:flutter/material.dart';
import 'package:mon_projet_flutter/views/qr_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QRScreen(),
    );
  }
}
