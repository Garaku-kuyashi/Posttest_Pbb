import 'package:flutter/material.dart';
import '../product/product.dart';
import 'cart_page.dart';
import 'profile_page.dart';


const Color warnaAksen = Color(0xFFFF7A00);
const Color warnaLatar = Colors.white;
const Color warnaAbuMuda = Color(0xFFF5F5F5);

class HomePage extends StatefulWidget {
  final List<Product> products;
  final KeranjangController keranjang;

  const HomePage({
    super.key,
    required this.products,
    required this.keranjang,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // searchQuery: state lokal, berubah setiap kali pengguna mengetik
  String searchQuery = '';

  // visibleProducts: daftar produk yang namanya mengandung searchQuery.
  // Dihitung ulang setiap kali build() dipanggil (setelah setState),
  // sama seperti contoh "visibleProducts" pada Modul 4.
  List<Product> get visibleProducts {
    return widget.products.where((product) {
      return product.name.toLowerCase().contains(searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold: struktur dasar halaman aplikasi mobile
    return Scaffold(
      backgroundColor: warnaLatar,

      appBar: AppBar(
        backgroundColor: warnaAksen,
        elevation: 0,
        title: const Text(
          'Toko Merch Anime',
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
                // SEARCH BAR
                // TextField: input pencarian produk
                TextField(
                  // onChanged: dipanggil setiap kali pengguna mengetik,
                  // lalu setState dipakai untuk mengubah searchQuery
                  // (konsep Modul 4: "State pada TextField")
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: warnaAbuMuda,
                    hintText: 'Cari merch anime',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
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

                const SizedBox(height: 16),

                // BANNER PROMO
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: warnaAksen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Diskon Spesial 30%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Untuk semua produk merch edisi terbatas',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // KATEGORI
                Row(
                  children: const [
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

                // JUDUL SECTION
                Text(
                  // Judul berubah jika sedang mencari, menampilkan jumlah hasil
                  searchQuery.isEmpty
                      ? 'Semua Produk'
                      : 'Hasil Pencarian (${visibleProducts.length})',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                // Pesan ditampilkan jika pencarian tidak menemukan produk apa pun
                if (visibleProducts.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        'Produk "$searchQuery" tidak ditemukan',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ),
                  ),

                // GRID PRODUK 2 KOLOM
                // Dibangun dari visibleProducts (sudah difilter searchQuery),
                // BUKAN dari widget.products langsung
                for (int i = 0; i < visibleProducts.length; i += 2)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ProductCard(
                            product: visibleProducts[i],
                            // onAddToCart: diteruskan dari MyApp lewat
                            // widget.keranjang, dipanggil saat tombol ditekan
                            onAddToCart: () =>
                                widget.keranjang.onAddToCart(visibleProducts[i]),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: i + 1 < visibleProducts.length
                              ? ProductCard(
                                  product: visibleProducts[i + 1],
                                  onAddToCart: () => widget.keranjang
                                      .onAddToCart(visibleProducts[i + 1]),
                                )
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

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: warnaAksen,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(keranjang: widget.keranjang),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(keranjang: widget.keranjang),
              ),
            );
          }
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            // Stack: menumpuk icon keranjang dengan badge jumlah di sudutnya
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart),
                // Positioned: menaruh badge di pojok kanan atas icon keranjang
                Positioned(
                  right: -6,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: warnaAksen,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    // Text: jumlah item di keranjang, berubah mengikuti state
                    child: Text(
                      '${widget.keranjang.cart.length}',
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
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

// KategoriItem 
class KategoriItem extends StatelessWidget {
  final String nama;
  final IconData icon;

  const KategoriItem({super.key, required this.nama, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: warnaAbuMuda, shape: BoxShape.circle),
          child: Icon(icon, color: warnaAksen),
        ),
        const SizedBox(height: 6),
        Text(nama, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    // habis: true jika stok produk ini sudah 0
    final habis = product.stock <= 0;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container: bingkai gambar produk, sudut atas dibuat melengkung
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
            // Image.asset: menampilkan gambar produk dari folder assets
            child: Image.asset(
              product.imageUrl,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
              // errorBuilder: gambar cadangan (icon) jika file belum ada
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 100,
                  alignment: Alignment.center,
                  color: warnaAbuMuda,
                  child: Icon(product.icon, size: 40, color: Colors.grey.shade500),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
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
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                    const Spacer(),
                    // Text: menampilkan sisa stok, ikut berubah tiap kali
                    // tombol Tambah ditekan (menunjukkan data ini adalah state)
                    Text(
                      habis ? 'Stok habis' : 'Stok ${product.stock}',
                      style: TextStyle(
                        fontSize: 10,
                        color: habis ? Colors.red : Colors.grey.shade500,
                        fontWeight: habis ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  formatRupiah(product.price),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: warnaAksen,
                  ),
                ),
                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: habis ? null : onAddToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: warnaAksen,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      habis ? 'Stok Habis' : 'Tambah',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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
