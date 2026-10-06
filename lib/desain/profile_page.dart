import 'package:flutter/material.dart';
import '../product/product.dart';
import 'desain.dart';
import 'cart_page.dart';


class ProfilePage extends StatelessWidget {
  final KeranjangController keranjang;

  const ProfilePage({super.key, required this.keranjang});

  @override
  Widget build(BuildContext context) {
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
          'Profil Saya',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Stack: menumpuk foto profil dengan icon edit di pojoknya
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      // Image.asset: foto profil dari folder assets
                      child: Image.asset(
                        'assets/profil.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: warnaAbuMuda,
                            alignment: Alignment.center,
                            child: Icon(Icons.person, size: 48, color: Colors.grey.shade400),
                          );
                        },
                      ),
                    ),
                    // Positioned: icon edit di pojok kanan bawah foto
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(color: warnaAksen, shape: BoxShape.circle),
                        child: const Icon(Icons.edit, size: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const Text('Nakama Otaku', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text('nakama.otaku@email.com', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),

                const SizedBox(height: 24),

                const ProfileMenuItem(icon: Icons.shopping_bag_outlined, label: 'Pesanan Saya'),
                const ProfileMenuItem(icon: Icons.location_on_outlined, label: 'Alamat Pengiriman'),
                const ProfileMenuItem(icon: Icons.settings_outlined, label: 'Pengaturan Akun'),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: warnaAksen,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage(keranjang: keranjang)),
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


// ProfileMenuItem 
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const ProfileMenuItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: warnaAksen),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}
