import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../product/product.dart';
import 'desain.dart';
import 'profile_page.dart';
import 'confirmation_page.dart';


class CartPage extends StatefulWidget {
  final KeranjangController keranjang;

  const CartPage({super.key, required this.keranjang});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = widget.keranjang.cart;
    final totalHarga = widget.keranjang.totalHarga;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: warnaAksen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Keranjang Saya',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      // body: daftar item, atau pesan "keranjang kosong" jika belum ada isinya
      body: SafeArea(
        child: cart.isEmpty
            // Jika keranjang kosong, state "cart" ini yang menentukan
            // tampilan mana yang muncul (bukan dua layar terpisah)
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 56,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Keranjang masih kosong',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      for (final item in cart)
                        CartItemCard(
                          item: item,
                          // onQuantityChanged: meneruskan perubahan jumlah
                          // ke MyApp lewat KeranjangController, lalu
                          // setState dipanggil di sana
                          onQuantityChanged: (jumlahBaru) =>
                              widget.keranjang.onQuantityChanged(item, jumlahBaru),
                          onRemove: () => widget.keranjang.onRemoveItem(item),
                        ),
                    ],
                  ),
                ),
              ),
      ),

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                // BoxShadow: bayangan tipis di atas bar total
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(
                      formatRupiah(totalHarga),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // ElevatedButton: tombol checkout.
                // onPressed bernilai null (nonaktif) ketika totalHarga == 0,
                // persis contoh "Tombol checkout" pada Modul 4:
                // onPressed: currentGrandTotal > 0 ? widget.onCheckout : null
                ElevatedButton(
                  onPressed: totalHarga > 0
                      ? () {
                          final totalSaatCheckout = totalHarga;
                          // onCheckoutSuccess: mengosongkan keranjang di MyApp
                          widget.keranjang.onCheckoutSuccess();
                          // Navigator.push: membuka halaman konfirmasi,
                          // membawa nilai total yang sudah dibayar
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmationPage(
                                total: totalSaatCheckout,
                                keranjang: widget.keranjang,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: warnaAksen,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          BottomNavigationBar(
            currentIndex: 1,
            selectedItemColor: warnaAksen,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              if (index == 0) {
                Navigator.pop(context);
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(keranjang: widget.keranjang),
                  ),
                );
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Keranjang'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
            ],
          ),
        ],
      ),
    );
  }
}

class CartItemCard extends StatefulWidget {
  final CartItem item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  // controller menampung teks yang diketik pada TextField jumlah barang
  late final TextEditingController _controller;

  // initState: dijalankan sekali saat card ini pertama kali dibuat.
  // Dipakai untuk mengisi controller dengan jumlah awal (konsep Modul 4,
  // persis seperti initState pada CartProductCard)
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '${widget.item.quantity}');
  }

  // didUpdateWidget: dijalankan ketika widget ini dibangun ulang dengan
  // data item yang BERBEDA dari sebelumnya (misal quantity berubah dari
  // luar, seperti saat tombol Tambah ditekan lagi di Beranda). Fungsinya
  // menyamakan teks di TextField dengan quantity yang terbaru, persis
  // konsep "didUpdateWidget" pada Modul 4.
  @override
  void didUpdateWidget(covariant CartItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final teksSekarang = '${widget.item.quantity}';
    if (oldWidget.item.quantity != widget.item.quantity &&
        _controller.text != teksSekarang) {
      _controller.text = teksSekarang;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // updateQuantity: memvalidasi teks yang diketik sebelum dikirim ke atas.
  // Menolak input kosong/bukan angka/kurang dari 1, sama seperti fungsi
  // "updateQuantity" pada Modul 4.
  void _updateQuantity(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 1) return;
    widget.onQuantityChanged(parsed);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.item.product;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack: menumpuk gambar produk dengan label diskon di atasnya
            Stack(
              children: [
                // Image.asset: menampilkan gambar produk dari folder assets
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    product.imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 70,
                        height: 70,
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                ),
                // Positioned: label kecil di pojok kiri atas gambar
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: const BoxDecoration(
                      color: warnaAksen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'SALE',
                      style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                      // IconButton: menghapus item ini dari keranjang
                      GestureDetector(
                        onTap: widget.onRemove,
                        child: Icon(Icons.delete_outline, size: 18, color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatRupiah(product.price),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: warnaAksen),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            SizedBox(
              width: 48,
              // TextField: input jumlah barang, hanya menerima angka
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                ),
                // onChanged: setiap kali teks berubah, panggil _updateQuantity
                // (konsep Modul 4: TextField -> updateQuantity -> onQuantityChanged)
                onChanged: _updateQuantity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
