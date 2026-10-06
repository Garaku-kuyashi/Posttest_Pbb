import 'package:flutter/material.dart';

class Product {
  final String name;
  final String category;
  final String description;
  final int price;
  final String rating;
  final String imageUrl;
  final IconData icon;
  int stock; // stock tidak final karena nilainya berubah-ubah 

  Product({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.icon,
    required this.stock,
  });
}

class Kategori {
  final String name;
  final IconData icon;

  const Kategori({required this.name, required this.icon});
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
class KeranjangController {
  final List<CartItem> cart;
  final void Function(Product product) onAddToCart;
  final void Function(CartItem item, int jumlahBaru) onQuantityChanged;
  final void Function(CartItem item) onRemoveItem;
  final VoidCallback onCheckoutSuccess;

  const KeranjangController({
    required this.cart,
    required this.onAddToCart,
    required this.onQuantityChanged,
    required this.onRemoveItem,
    required this.onCheckoutSuccess,
  });

  // getter: total harga seluruh item di keranjang (jumlah dikali harga satuan)
  int get totalHarga {
    int total = 0;
    for (final item in cart) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}


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

const List<Kategori> daftarKategori = [
  Kategori(name: 'Figure', icon: Icons.toys),
  Kategori(name: 'Apparel', icon: Icons.checkroom),
  Kategori(name: 'Aksesoris', icon: Icons.key),
];

List<Product> daftarProduct = [
  Product(
    name: 'Nendroid Korone',
    category: 'Figure',
    description: 'Nendroid, tinggi 10 cm',
    price: 520000,
    rating: '4.9',
    imageUrl: 'assets/korone.jpg',
    icon: Icons.toys,
    stock: 5,
  ),
  Product(
    name: 'Hoodie Anime Attack On Titan',
    category: 'Apparel',
    description: 'Bahan fleece, ukuran L',
    price: 310000,
    rating: '4.8',
    imageUrl: 'assets/hoodie.jpg',
    icon: Icons.checkroom,
    stock: 12,
  ),
  Product(
    name: 'Acrylic Stand Camile Arknights: Endfield',
    category: 'Aksesoris',
    description: 'Akrilik 5 cm dengan base',
    price: 35000,
    rating: '4.9',
    imageUrl: 'assets/acrlik.jpg',
    icon: Icons.key,
    stock: 0,
  ),
  Product(
    name: 'Totebag One Piece',
    category: 'Apparel',
    description: 'Kanvas tebal, muat laptop 14"',
    price: 120000,
    rating: '4.6',
    imageUrl: 'assets/totebag.jpg',
    icon: Icons.shopping_bag,
    stock: 15,
  ),
  Product(
    name: 'Mousepad Hatsune Miku XL',
    category: 'Aksesoris',
    description: 'Ukuran 80x30 cm, anti slip',
    price: 150000,
    rating: '4.8',
    imageUrl: 'assets/mouse.jpg',
    icon: Icons.mouse,
    stock: 8,
  ),
];
