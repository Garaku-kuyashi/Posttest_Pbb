import 'package:flutter/material.dart';
import 'product/product.dart';
import 'desain/desain.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // products: daftar produk yang stoknya bisa berkurang
  late List<Product> products;
  // cart: daftar item yang sedang ada di keranjang
  late List<CartItem> cart;

  // initState: dijalankan sekali saat MyApp pertama kali dibuat,
  // dipakai untuk menyiapkan nilai awal state (konsep Modul 4)
  @override
  void initState() {
    super.initState();
    products = daftarProduct;
    cart = [];
  }

  // Dipanggil saat tombol "Tambah" di ProductCard ditekan
  void _addToCart(Product product) {
    // setState: memberi tahu Flutter agar UI dibangun ulang
    // karena ada data (stock & cart) yang berubah
    setState(() {
      if (product.stock <= 0) return; // jaga-jaga, harusnya tombol sudah nonaktif
      product.stock -= 1;

      // Jika produk sudah ada di keranjang, cukup tambah jumlahnya
      final index = cart.indexWhere((item) => item.product.name == product.name);
      if (index >= 0) {
        cart[index].quantity += 1;
      } else {
        cart.add(CartItem(product: product));
      }
    });
  }

  // Dipanggil saat jumlah pada TextField di CartItemCard diubah
  void _changeQuantity(CartItem item, int jumlahBaru) {
    setState(() {
      // batas maksimal = stok yang tersisa + jumlah yang sudah diambil
      final maxQuantity = item.product.stock + item.quantity;
      final clamped = jumlahBaru.clamp(1, maxQuantity);
      // selisih dipakai untuk menyesuaikan stok produk terkait
      final selisih = clamped - item.quantity;
      item.product.stock -= selisih;
      item.quantity = clamped;
    });
  }

  // Dipanggil saat tombol hapus pada item keranjang ditekan
  void _removeItem(CartItem item) {
    setState(() {
      item.product.stock += item.quantity; // stok dikembalikan
      cart.remove(item);
    });
  }

  // Dipanggil setelah checkout berhasil, untuk mengosongkan keranjang
  void _checkoutSuccess() {
    setState(() {
      cart = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // keranjang: membungkus data & fungsi-fungsi di atas menjadi satu
    // objek agar mudah diteruskan ke HomePage, CartPage, dan ProfilePage
    final keranjang = KeranjangController(
      cart: cart,
      onAddToCart: _addToCart,
      onQuantityChanged: _changeQuantity,
      onRemoveItem: _removeItem,
      onCheckoutSuccess: _checkoutSuccess,
    );

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
        scaffoldBackgroundColor: Colors.white,
      ),
      // home: halaman yang pertama kali ditampilkan, menerima data
      // produk dan keranjang dari state MyApp ini
      home: HomePage(products: products , keranjang: keranjang),
    );
  }
}
