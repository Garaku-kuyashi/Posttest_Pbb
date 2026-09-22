import 'package:flutter/material.dart';

// ============================================================
// Model data produk (bukan widget)
// ============================================================
class Product {
  final String name;
  final String category;
  final String price;
  final String rating;
  final IconData icon;

  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.icon,
  });
}

// ============================================================
// Model data kategori (bukan widget)
// ============================================================
class Kategori {
  final String name;
  final IconData icon;

  const Kategori({required this.name, required this.icon});
}

// ============================================================
// Daftar kategori untuk chip di homepage
// ============================================================
const List<Kategori> daftarKategori = [
  Kategori(name: 'Semua', icon: Icons.apps),
  Kategori(name: 'Figure', icon: Icons.toys),
  Kategori(name: 'Apparel', icon: Icons.checkroom),
  Kategori(name: 'Poster', icon: Icons.image),
  Kategori(name: 'Aksesoris', icon: Icons.key),
];

// ============================================================
// Daftar produk yang ditampilkan di homepage
// ============================================================
const List<Product> daftarProduct = [
  Product(
    name: 'Figure Sorasaki Hina',
    category: 'Figure',
    price: 'Rp520.000',
    rating: '4.9',
    icon: Icons.toys,
  ),
  Product(
    name: 'Hoodie Kiana Kaslana HI3',
    category: 'Apparel',
    price: 'Rp310.000',
    rating: '4.8',
    icon: Icons.checkroom,
  ),
  Product(
    name: 'Poster Plana Blue Archive',
    category: 'Poster',
    price: 'Rp85.000',
    rating: '4.7',
    icon: Icons.image,
  ),
  Product(
    name: 'Keychain Acrylic Arknight',
    category: 'Aksesoris',
    price: 'Rp35.000',
    rating: '4.9',
    icon: Icons.key,
  ),
  Product(
    name: 'Tote Bag Genshin Impact',
    category: 'Apparel',
    price: 'Rp120.000',
    rating: '4.6',
    icon: Icons.shopping_bag,
  ),
  Product(
    name: 'Mousepad Sakura XL',
    category: 'Aksesoris',
    price: 'Rp150.000',
    rating: '4.8',
    icon: Icons.mouse,
  ),
];