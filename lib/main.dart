import 'package:flutter/material.dart';
// Mengimpor halaman dari folder Desain
import 'desain/desain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: widget wrapper utama dari aplikasi Flutter
    return MaterialApp(
      // nama aplikasi
      title: 'Toko Merch Anime',
      // debugShowCheckedModeBanner: menonaktifkan tulisan debug di pojok kanan atas
      debugShowCheckedModeBanner: false,
      // theme: aturan visual umum aplikasi
      theme: ThemeData(
        // colorScheme: skema warna dibuat dari satu warna dasar 
        colorScheme: ColorScheme.fromSeed(seedColor: warnaAksen),
        // scaffoldBackgroundColor: warna latar default seluruh halaman
        scaffoldBackgroundColor: Colors.white,
      ),
      // home: halaman yang pertama kali ditampilkan
      home: const HomePage(),
    );
  }
}