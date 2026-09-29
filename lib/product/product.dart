import 'package:flutter/material.dart';


class Product {
  final String name;
  final String category;
  final String price;
  final String rating;
  final String imageUrl;

  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });
}

// Model data kategori 
class Kategori {
  final String name;
  final IconData icon;

  const Kategori({required this.name, required this.icon});
}

// Model data item keranjang 
class CartItem {
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}

// Fungsi bantuan untuk mengubah angka menjadi format rupiah contoh: 520000 menjadi "Rp520.000"
String formatRupiah(int angka) {
  final teksAngka = angka.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < teksAngka.length; i++) {
    final posisiDariKanan = teksAngka.length - i;
    buffer.write(teksAngka[i]);
    if (posisiDariKanan > 1 && posisiDariKanan % 3 == 1) {
      buffer.write('.');
    }
  }
  return 'Rp$buffer';
}

// Daftar kategori untuk baris kategori di homepage
const List<Kategori> daftarKategori = [
  Kategori(name: 'Figure', icon: Icons.toys),
  Kategori(name: 'Apparel', icon: Icons.checkroom),
  Kategori(name: 'Poster', icon: Icons.image),
  Kategori(name: 'Aksesoris', icon: Icons.key),
];

// Daftar produk yang ditampilkan di homepage
const List<Product> daftarProduct = [
  Product(
    name: 'Nendroid Korone',
    category: 'Figure',
    price: 'Rp520.000',
    rating: '4.9',
    imageUrl: 'assets/korone.jpg',
  ),
  Product(
    name: 'Hoodie Anime Attack On Titan',
    category: 'Apparel',
    price: 'Rp310.000',
    rating: '4.8',
    imageUrl: 'assets/hoodie.jpg',
  ),
  Product(
    name: 'Acrylic Stand Camile Arknights:Endfield',
    category: 'Aksesoris',
    price: 'Rp35.000',
    rating: '4.9',
    imageUrl: 'assets/acrlik.jpg',
  ),
  Product(
    name: 'Totebag One Piece',
    category: 'Apparel',
    price: 'Rp120.000',
    rating: '4.6',
    imageUrl: 'totebag.jpg',
  ),
  Product(
    name: 'Mousepad Hatsune Miku XL',
    category: 'Aksesoris',
    price: 'Rp150.000',
    rating: '4.8',
    imageUrl: 'mouse.jpg',
  ),
];

List<CartItem> daftarKeranjang = [
  CartItem(
    name: 'Nendroid Korone',
    description: 'Nendroid, tinggi 10 cm',
    price: 520000,
    imageUrl: 'assets/korone.jpg',
  ),
  CartItem(
    name: 'Hoodie Anime Attack On Titan',
    description: 'Bahan fleece, ukuran L',
    price: 310000,
    imageUrl: 'assets/hoodie.jpg',
  ),
  CartItem(
    name: 'Acrylic Stand Camile Arknights:Endfield',
    description: 'Akrilik 5 cm',
    price: 35000,
    imageUrl: 'assets/acrlik.jpg',
  ),
];