import 'package:flutter/material.dart';
import '../product/product.dart';
import 'desain.dart';
import 'cart_page.dart';
import 'profile_page.dart';


class ConfirmationPage extends StatelessWidget {
  final int total;
  final KeranjangController keranjang;

  const ConfirmationPage({
    super.key,
    required this.total,
    required this.keranjang,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // Center: menempatkan seluruh konten tepat di tengah layar
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container: lingkaran hitam berisi icon centang
              Container(
                width: 72,
                height: 72,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 16),
              // Text: label "Total"
              const Text(
                'Total',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              // Text: nominal total yang sudah dibayar, dikirim dari CartPage
              Text(
                formatRupiah(total),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // ElevatedButton: tombol kembali ke Beranda
              ElevatedButton(
                onPressed: () {
                  // Navigator.popUntil: menutup semua halaman yang ditumpuk
                  // di atas Beranda (Keranjang & Konfirmasi), sehingga
                  // pengguna langsung kembali ke halaman pertama
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),

      // bottomNavigationBar: tetap ditampilkan agar konsisten dengan
      // halaman lain, menu Keranjang ditandai aktif
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: warnaAksen,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(keranjang: keranjang),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(keranjang: keranjang),
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
    );
  }
}
