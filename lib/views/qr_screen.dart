import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mon_projet_flutter/models/room.dart';
import 'package:mon_projet_flutter/views/room_screen.dart';
import 'dart:ui' as ui;

import 'package:native_barcode_scanner/barcode_scanner.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  void _onBarcodeDetected(BuildContext context, Barcode barcode) {
    try {
      final qrCodeValue = jsonDecode(barcode.value);
      final room = Room.fromJson(qrCodeValue);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return RoomScreen(
              room: room,
            );
          },
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Il semble que ce QR Code ne soit pas valide'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;
                final maxSize = width > height ? height : width;
                final containerSize = maxSize * 0.9;
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  width: containerSize,
                  height: containerSize,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BarcodeScannerWidget(
                      stopScanOnBarcodeDetected: false,
                      onBarcodeDetected: (barcode) {
                        print('Barcode detected: ${barcode.value}');
                      },
                      onError: (error) {
                        print('Barcode Error: $error');
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
