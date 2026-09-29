import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../product/product.dart';
import 'desain.dart';
import 'profile_page.dart';

// halaman keranjang belanja
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Menghitung total harga dari seluruh item di keranjang
  int get totalHarga {
    int total = 0;
    for (final item in daftarKeranjang) {
      total += item.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold: struktur dasar halaman keranjang
    return Scaffold(
      backgroundColor: Colors.white,

      // appBar: bar atas dengan tombol kembali dan judul halaman
      appBar: AppBar(
        backgroundColor: warnaAksen,
        elevation: 0,
        // leading: tombol kembali manual memakai Navigator.pop
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          // Navigator.pop: kembali ke halaman sebelumnya (HomePage)
          onPressed: () => Navigator.pop(context),
        ),
        // Text: judul halaman
        title: const Text(
          'Keranjang Saya',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      // body: daftar item keranjang yang bisa di-scroll
      body: SafeArea(
        // SingleChildScrollView: agar daftar item bisa di-scroll (1 child)
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          // Padding: jarak di sekeliling daftar item
          child: Padding(
            padding: const EdgeInsets.all(16),
            // Column: menyusun setiap CartItemCard secara vertikal
            child: Column(
              children: [
                // Perulangan: satu CartItemCard untuk setiap item keranjang
                for (final item in daftarKeranjang)
                  CartItemCard(
                    item: item,
                    // setState dipanggil agar Total di bawah ikut diperbarui
                    // ketika jumlah (quantity) barang berubah
                    onQuantityChanged: () => setState(() {}),
                  ),
              ],
            ),
          ),
        ),
      ),

      // bottomNavigationBar: menu navigasi + ringkasan total & checkout
      bottomNavigationBar: Column(
        // mainAxisSize.min: tinggi Column mengikuti isi, tidak memenuhi layar
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container: bar total harga dan tombol checkout
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            // BoxDecoration: warna latar dan bayangan di sisi atas bar
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                // BoxShadow: memberi efek bayangan tipis di atas bar total
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  // offset negatif pada sumbu y membuat bayangan ke arah atas
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            // Row: total harga di kiri, tombol checkout di kanan
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Column: label "Total" dan nominalnya
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    // Text: total harga terformat rupiah, ikut berubah
                    // setiap kali quantity item diubah lewat TextField
                    Text(
                      formatRupiah(totalHarga),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Container: tombol checkout
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: warnaAksen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Checkout Sekarang',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // BottomNavigationBar: navigasi bawah, menu Keranjang aktif
          BottomNavigationBar(
            currentIndex: 1,
            selectedItemColor: warnaAksen,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              if (index == 0) {
                // Navigator.pop: kembali ke HomePage yang ada di bawahnya
                Navigator.pop(context);
              } else if (index == 2) {
                // Navigator.push: membuka halaman ProfilePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Keranjang',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
            ],
          ),
        ],
      ),
    );
  }
}

// CartItemCard : satu baris item pada daftar keranjang
class CartItemCard extends StatefulWidget {
  final CartItem item;
  final VoidCallback onQuantityChanged;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  // controller menampung teks yang diketik pada TextField jumlah barang
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '${widget.item.quantity}');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Padding: jarak bawah antar card item
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      // Container: pembungkus satu baris item keranjang
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        // Row: gambar, detail produk, dan input jumlah berdampingan
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack: menumpuk gambar produk dengan label diskon di atasnya
            Stack(
              children: [
                // Image.network: menampilkan gambar produk dari internet
                // (dipakai sebagai pengganti Image.asset karena belum ada
                // file gambar lokal di folder assets)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.item.imageUrl,
                    // width dan height: mengatur ukuran gambar
                    width: 70,
                    height: 70,
                    // fit: BoxFit.cover agar gambar memenuhi area tanpa gepeng
                    fit: BoxFit.cover,
                  ),
                ),
                // Positioned: menaruh label "SALE" di pojok kiri atas gambar
                Positioned(
                  left: 0,
                  top: 0,
                  // Container: label kecil bertuliskan SALE
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: const BoxDecoration(
                      color: warnaAksen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'SALE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Expanded: detail nama, deskripsi, dan harga mengisi sisa ruang
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text: nama produk
                  Text(
                    widget.item.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Text: deskripsi singkat produk
                  Text(
                    widget.item.description,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 4),
                  // Text: harga satuan produk
                  Text(
                    formatRupiah(widget.item.price),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: warnaAksen,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // SizedBox: membatasi lebar TextField jumlah barang
            SizedBox(
              width: 48,
              // TextField: input jumlah barang, hanya menerima angka
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                // keyboardType number: memunculkan keyboard angka saja
                keyboardType: TextInputType.number,
                // inputFormatters: memastikan hanya karakter angka (0-9)
                // yang bisa diketik, huruf dan simbol otomatis ditolak
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                // onChanged: dipanggil setiap kali angka jumlah diubah
                onChanged: (value) {
                  final jumlahBaru = int.tryParse(value);
                  if (jumlahBaru != null && jumlahBaru > 0) {
                    widget.item.quantity = jumlahBaru;
                    // memberi tahu CartPage agar Total dihitung ulang
                    widget.onQuantityChanged();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
