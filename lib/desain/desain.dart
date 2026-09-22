import 'package:flutter/material.dart';
// Mengimpor model dan data produk dari folder Product
import '../product/product.dart';

// ============================================================
// warna tema 
// ============================================================
const Color warnaAksen = Color(0xFFFF7A00);
const Color warnaLatar = Colors.white;
const Color warnaAbuMuda = Color(0xFFF5F5F5);

// ============================================================
// halaman utama
// ============================================================
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
          'My Hobby Store',
          // TextStyle: mengatur gaya teks judul
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),


      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------- SEARCH BAR ----------
                // TextField: input pencarian produk
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: warnaAbuMuda,
                    // hintText: placeholder pada input
                    hintText: 'Cari merch anime sesuai hobby mu :)',
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
                const SizedBox(height: 20),

                // ---------- KATEGORI ----------
                // Row: pilihan kategori sejajar horizontal
                Row(
                  children: const [
                    // Expanded: setiap kategori membagi lebar sama rata
                    Expanded(child: KategoriItem(nama: 'Figure', icon: Icons.toys)),
                    Expanded(
                      child: KategoriItem(nama: 'Apparel', icon: Icons.checkroom),
                    ),
                    Expanded(child: KategoriItem(nama: 'Poster', icon: Icons.image)),
                    Expanded(
                      child: KategoriItem(nama: 'Aksesoris', icon: Icons.key),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ---------- JUDUL SECTION ----------
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
        items: const [
          // Item menu Beranda
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          // Item menu Keranjang
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          // Item menu Profil
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

// ============================================================
// KategoriItem : satu ikon kategori dengan label di bawahnya
// ============================================================
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

// ============================================================
// ProductCard : card vertikal untuk satu produk
// ============================================================
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Container: kotak card 
    return Container(
      // BoxDecoration: mengatur bingkai dan kelengkungan card
      decoration: BoxDecoration(
        // border: bingkai tipis di sekeliling card
        border: Border.all(color: Colors.grey.shade300),
        // borderRadius: kelengkungan sudut card
        borderRadius: BorderRadius.circular(10),
      ),
      // Column: gambar di atas, detail produk di bawah
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container: placeholder gambar produk
          Container(
            width: double.infinity,
            height: 100,
            // alignment: icon ditempatkan di tengah kotak gambar
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: warnaAbuMuda,
              // BorderRadius.vertical: hanya sudut atas yang melengkung
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(9),
              ),
            ),
            // Icon: gambar sementara sesuai jenis produk
            child: Icon(product.icon, size: 40, color: Colors.grey.shade500),
          ),

          // Padding: ruang di sekeliling detail produk
          Padding(
            // EdgeInsets.all: jarak sama di semua sisi
            padding: const EdgeInsets.all(8),
            // Column: susunan detail produk
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // text: nama produk
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // SizedBox: jarak vertikal kecil
                const SizedBox(height: 2),
                // Text: kategori produk
                Text(
                  product.category,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 4),
                // Row: bintang dan rating
                Row(
                  children: [
                    // Icon: bintang rating
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    // SizedBox: jarak antara bintang dan angka
                    const SizedBox(width: 4),
                    // Text: nilai rating
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
                // Text: harga produk
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: warnaAksen,
                  ),
                ),
                const SizedBox(height: 8),

                // Container: tombol "Tambah ke Keranjang"
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: warnaAksen,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  // Text: label tombol
                  child: const Text(
                    'Tambah',
                    // textAlign: teks diposisikan di tengah
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