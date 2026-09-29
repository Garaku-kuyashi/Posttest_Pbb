import 'package:flutter/material.dart';
import '../product/product.dart';
import 'cart_page.dart';
import 'profile_page.dart';

const Color warnaAksen = Color(0xFFFF7A00);
const Color warnaLatar = Colors.white;
const Color warnaAbuMuda = Color(0xFFF5F5F5);

// HomePage : halaman utama
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: struktur dasar halaman aplikasi mobile
    return Scaffold(
      // backgroundColor: warna latar halaman
      backgroundColor: warnaLatar,
      // appBar: bar di bagian atas halaman
      appBar: AppBar(
        backgroundColor: warnaAksen,
        elevation: 0,
        // Text: judul aplikasi
        title: const Text(
          'Toko Merch Anime',
          // TextStyle: mengatur gaya teks judul
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      // konten utama halaman
      // SafeArea: memastikan konten tidak tertutup area perangkat
      body: SafeArea(
        // SingleChildScrollView: membuat halaman bisa di-scroll (1 child)
        child: SingleChildScrollView(
          // scrollDirection: arah scrolling halaman
          scrollDirection: Axis.vertical,
          // Padding: ruang di sekeliling seluruh konten
          child: Padding(
            // EdgeInsets.symmetric: jarak kiri-kanan 16, atas-bawah 12
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            // Column: menyusun semua bagian secara vertikal
            child: Column(
              // crossAxisAlignment: seluruh anak rata kiri
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextField: input pencarian produk
                TextField(
                  // decoration: tampilan field lewat InputDecoration
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: warnaAbuMuda,
                    // hintText: placeholder pada input
                    hintText: 'Cari merch anime',
                    // hintStyle: gaya teks placeholder
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    // suffixIcon: icon di ujung kanan field
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      semanticLabel: 'Cari',
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                // SizedBox: jarak vertikal antar bagian
                const SizedBox(height: 16),

                // banner promo
                // Container: banner warna polos dengan sudut melengkung
                Container(
                  width: double.infinity,
                  // EdgeInsets.all: jarak di dalam banner
                  padding: const EdgeInsets.all(16),
                  // BoxDecoration: warna latar dan kelengkungan
                  decoration: BoxDecoration(
                    color: warnaAksen,
                    // borderRadius: kelengkungan sudut banner
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Column: dua baris teks promo
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text: judul promo
                      Text(
                        'Diskon Spesial 30%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // SizedBox: jarak antar teks
                      SizedBox(height: 4),
                      // Text: keterangan promo
                      Text(
                        'Untuk semua produk merch edisi terbatas',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Kategori
                // Row: pilihan kategori sejajar horizontal
                Row(
                  children: const [
                    // Expanded: setiap kategori membagi lebar sama rata
                    Expanded(
                      child: KategoriItem(nama: 'Figure', icon: Icons.toys),
                    ),
                    Expanded(
                      child: KategoriItem(
                        nama: 'Apparel',
                        icon: Icons.checkroom,
                      ),
                    ),
                    Expanded(
                      child: KategoriItem(nama: 'Poster', icon: Icons.image),
                    ),
                    Expanded(
                      child: KategoriItem(nama: 'Aksesoris', icon: Icons.key),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Text: judul daftar produk
                const Text(
                  'Semua Produk',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                // Setiap baris berisi 2 produk (dibuat dari Row + Expanded)
                for (int i = 0; i < daftarProduct.length; i += 2)
                  // Padding: jarak bawah antar baris produk
                  Padding(
                    // EdgeInsets.only: jarak hanya di sisi bawah
                    padding: const EdgeInsets.only(bottom: 12),
                    // Row: dua card produk berdampingan
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expanded: card kiri mengisi setengah lebar
                        Expanded(child: ProductCard(product: daftarProduct[i])),
                        // SizedBox: jarak antar dua card
                        const SizedBox(width: 12),
                        // Expanded: card kanan (kosong jika jumlah produk ganjil)
                        Expanded(
                          child: i + 1 < daftarProduct.length
                              ? ProductCard(product: daftarProduct[i + 1])
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),

      // bottomNavigationBar: navigasi di bagian bawah halaman
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: menu yang sedang aktif (Beranda)
        currentIndex: 0,
        selectedItemColor: warnaAksen,
        unselectedItemColor: Colors.grey,
        // onTap: dipanggil setiap kali salah satu menu ditekan
        onTap: (index) {
          if (index == 1) {
            // Navigator.push: membuka halaman CartPage di atas HomePage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          } else if (index == 2) {
            // Navigator.push: membuka halaman ProfilePage di atas HomePage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
          // index == 0 (Beranda) tidak melakukan apa-apa karena sudah di halaman ini
        },
        items: [
          // Item menu Beranda
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          // Item menu Keranjang, iconnya diberi badge jumlah barang
          BottomNavigationBarItem(
            // Stack: menumpuk icon keranjang dengan badge jumlah di sudutnya
            icon: Stack(
              // clipBehavior none: agar badge boleh sedikit keluar dari area icon
              clipBehavior: Clip.none,
              children: [
                // Icon keranjang ditulis lebih dulu sehingga berada di belakang/dasar
                const Icon(Icons.shopping_cart),
                // Positioned: menaruh badge di pojok kanan atas icon keranjang
                Positioned(
                  right: -6,
                  top: -4,
                  // Container: lingkaran kecil berisi angka jumlah item
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: warnaAksen,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    // Text: menampilkan total jumlah item di keranjang
                    child: Text(
                      '${daftarKeranjang.length}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            label: 'Keranjang',
          ),
          // Item menu Profil
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// KategoriItem : satu ikon kategori dengan label di bawahnya
class KategoriItem extends StatelessWidget {
  final String nama;
  final IconData icon;

  const KategoriItem({super.key, required this.nama, required this.icon});

  @override
  Widget build(BuildContext context) {
    // Column: icon di atas, teks nama kategori di bawah
    return Column(
      children: [
        // Container: lingkaran latar untuk icon kategori
        Container(
          width: 52,
          height: 52,
          // alignment: menempatkan icon tepat di tengah lingkaran
          alignment: Alignment.center,
          // BoxDecoration: warna latar dan bentuk lingkaran
          decoration: BoxDecoration(
            color: warnaAbuMuda,
            shape: BoxShape.circle,
          ),
          // Icon: icon kategori
          child: Icon(icon, color: warnaAksen),
        ),
        // SizedBox: jarak antara icon dan teks
        const SizedBox(height: 6),
        // Text: nama kategori
        Text(nama, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}

// ProductCard : card vertikal untuk satu produk
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // GAMBAR PRODUK
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(9),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 110,
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Detail produk
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  product.category,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      product.rating,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: warnaAksen,
                  ),
                ),
                const SizedBox(height: 8),

                // Tombol Tambah
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: warnaAksen,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Tambah',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}