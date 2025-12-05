import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodsplash/models/menu_item.dart';
import 'package:foodsplash/pages/homepage.dart';
import 'package:foodsplash/pages/pesanandiproses.dart';
import 'package:foodsplash/pages/promo_page.dart';
import 'package:foodsplash/pages/akun_page.dart';
import 'package:foodsplash/pages/checkout_page.dart';
import 'package:foodsplash/models/cart_item.dart';

class CustomPesananPage extends StatefulWidget {
  final MenuItem menu; // ⬅️ simpan menu ke field

  const CustomPesananPage({super.key, required this.menu});

  @override
  State<CustomPesananPage> createState() => _CustomPesananPageState();
}

class _CustomPesananPageState extends State<CustomPesananPage> {
  int qty = 1;
  final TextEditingController _catatan = TextEditingController();

  late int basePrice; // akan diisi dari menu

  @override
  void initState() {
    super.initState();
    basePrice = widget.menu.harga.toInt(); // harga dari database
  }

  @override
  Widget build(BuildContext context) {
    final int totalPrice = qty * basePrice;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Custom Pesanan",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER GAMBAR PRODUK
            Stack(
              children: [
                Image.asset(
                  'assets/images/martabak.png',
                  width: double.infinity,
                  height: 260,
                  fit: BoxFit.cover,
                ),
                Positioned(top: 40, right: 16, child: _ratingBadge()),
                Positioned(bottom: -25, left: 20, child: _productTitle()),
              ],
            ),

            const SizedBox(height: 35),

            // KETERANGAN & NUTRISI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _keterangan()),
                  const SizedBox(width: 20),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // TAG INFO & KALORI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    spacing: 8,
                    children: [_tag('Rescued'), _tag('Vegan'), _tag('30 min')],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/vectors/fire.svg',
                        height: 14,
                        colorFilter: const ColorFilter.mode(
                          // ✅ Ganti 'color' dengan 'colorFilter'
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            _bahanBahan(),

            const SizedBox(height: 20),
            _catatanRestoran(),

            const SizedBox(height: 30),

            // ORDER BAR
            _orderBar(totalPrice),

            const SizedBox(height: 20),

            // KONFIRMASI BUTTON
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF32B7E8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  final cartItem = CartItem(
                    id: widget.menu.id,
                    namaMenu: widget.menu.namaMenu,
                    deskripsi: widget.menu.deskripsi ?? '',
                    imageUrl: widget.menu.imageUrl ?? '',
                    qty: qty,
                    harga: widget.menu.harga.toInt(), // harga dari DB
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutPage(
                        items: [cartItem], // ⬅️ kirim list berisi 1 item
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Konfirmasi',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),

      // NAVBAR BAWAH
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(Icons.home, 'Produk', false, () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              }),
              _buildNavItem(Icons.article_outlined, 'Aktivitas', true, () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PesananDiprosesPage(),
                  ),
                );
              }),
              _buildNavItem(Icons.percent, 'Promo', false, () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PromoPage()),
                );
              }),
              _buildNavItem(Icons.person_outline, 'Akun', false, () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AkunPage()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // ======== SUBWIDGETS =========

  Widget _ratingBadge() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.5),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.white, size: 12),
        SizedBox(width: 4),
        Text('4.5', style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    ),
  );

  Widget _productTitle() => Container(
    width: 220,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.menu.namaMenu,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A4A4A),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          widget.menu.deskripsi ?? '',
          style: const TextStyle(fontSize: 12, color: Color(0xFF616161)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  Widget _keterangan() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Keterangan',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5D5858),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        widget.menu.deskripsi ?? '-',
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xFF5D5858),
          height: 1.4,
        ),
      ),
    ],
  );

  Widget _tag(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFE9E9E9)),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
    ),
  );

  Widget _bahanBahan() {
    final List<String> bahanImages = [
      'assets/images/bahan_telur.png',
      'assets/images/bahan_tepung.png',
      'assets/images/bahan_daging.png',
      'assets/images/bahan_sayur.png',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bahan-Bahan',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: bahanImages.map((path) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(path),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _catatanRestoran() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Catatan Untuk Restoran',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        const Text(
          'Optional',
          style: TextStyle(color: Colors.grey, fontSize: 10),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE7E8ED)),
          ),
          child: TextField(
            controller: _catatan,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText:
                  '(Makanan yang membuat Anda alergi, saus ekstra misalnya)',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 11),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _orderBar(int totalPrice) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF32B7E8),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Rp $totalPrice',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              _qtyButton('-', () {
                setState(() {
                  if (qty > 1) qty--;
                });
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '$qty',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _qtyButton('+', () {
                setState(() {
                  qty++;
                });
              }),
            ],
          ),
        ],
      ),
    ),
  );

  Widget _qtyButton(String label, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// Bottom Navbar Item
Widget _buildNavItem(
  IconData icon,
  String label,
  bool isActive,
  VoidCallback onTap,
) {
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Colors.lightBlue : Colors.grey),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.lightBlue : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
