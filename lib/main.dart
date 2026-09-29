import 'package:flutter/material.dart';
import 'Desain/desain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: widget wrapper utama dari aplikasi Flutter
    return MaterialApp(
      // title: nama aplikasi (String)
      title: 'Toko Merch Anime',
      // debugShowCheckedModeBanner: menonaktifkan tulisan debug di pojok kanan atas
      debugShowCheckedModeBanner: false,
      // theme: aturan visual umum aplikasi
      theme: ThemeData(
        // colorScheme: skema warna dibuat dari satu warna dasar (seed)
        colorScheme: ColorScheme.fromSeed(seedColor: warnaAksen),
        // scaffoldBackgroundColor: warna latar default seluruh halaman
        scaffoldBackgroundColor: Colors.white,
      ),
      // home: halaman yang pertama kali ditampilkan
      home: const HomePage(),
    );
  }
}