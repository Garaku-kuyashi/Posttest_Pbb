import 'package:flutter/material.dart';
import 'desain.dart';
import 'cart_page.dart';

//halaman profil pengguna
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: struktur dasar halaman profil
    return Scaffold(
      backgroundColor: Colors.white,

      // appBar: bar atas dengan tombol kembali dan judul halaman
      appBar: AppBar(
        backgroundColor: warnaAksen,
        elevation: 0,
        // leading: tombol kembali manual memakai Navigator.pop
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          // Navigator.pop: kembali ke halaman sebelumnya
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
                // foto profil
                // Stack: menumpuk foto profil dengan icon edit di pojoknya
                Stack(
                  children: [
                    // ClipRRect + Image.network: menampilkan foto profil bulat
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'korone.jpg',
                        // width dan height sama besar agar berbentuk lingkaran
                        width: 100,
                        height: 100,
                        // fit: BoxFit.cover agar foto memenuhi lingkaran
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Positioned: menaruh icon edit di pojok kanan bawah foto
                    Positioned(
                      right: 0,
                      bottom: 0,
                      // Container: lingkaran kecil pembungkus icon edit
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: warnaAksen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Text: nama pengguna
                const Text(
                  'KelinciBeku',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                // Text: email pengguna
                Text(
                  'kelinci@gmail.com',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),

                const SizedBox(height: 24),

                // menu profile
                const ProfileMenuItem(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Pesanan Saya',
                ),
                const ProfileMenuItem(
                  icon: Icons.location_on_outlined,
                  label: 'Alamat Pengiriman',
                ),
                const ProfileMenuItem(
                  icon: Icons.settings_outlined,
                  label: 'Pengaturan Akun',
                ),
              ],
            ),
          ),
        ),
      ),

      // bottomNavigationBar: navigasi bawah, menu Profil aktif
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: warnaAksen,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            // Navigator.pop: kembali ke HomePage
            Navigator.pop(context);
          } else if (index == 1) {
            // Navigator.push: membuka halaman CartPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
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
    );
  }
}

// ProfileMenuItem : satu baris menu pada halaman profil
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const ProfileMenuItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    // Container: pembungkus satu baris menu profil
    return Container(
      // margin: jarak bawah antar menu
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      // Row: icon, label, dan panah di kanan
      child: Row(
        children: [
          // Icon: gambar menu
          Icon(icon, color: warnaAksen),
          const SizedBox(width: 12),
          // Expanded: label mengisi sisa ruang agar panah tetap di kanan
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 14)),
          ),
          // Icon: panah penunjuk arah
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}
