import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:foodsplash/pages/homepage.dart';
import 'package:foodsplash/pages/customalamat.dart';
import 'package:foodsplash/pages/checkout_success_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodsplash/models/cart_item.dart';

// ====================== HALAMAN CHECKOUT ======================

class CheckoutPage extends StatefulWidget {
  final List<CartItem> items; // ⬅️ field baru

  const CheckoutPage({
    super.key,
    required this.items,      // ⬅️ parameter baru
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _alamatUtama = 'Jl. Situ Indah No 53, Depok';

  // pembayaran terpilih
  String _selectedPaymentLabel = 'Tunai';
  String _selectedPaymentCode = 'cash';

  bool _isSubmitting = false;

  int get _hargaTotal =>
      widget.items.fold(0, (sum, item) => sum + item.subtotal);

  int get _biayaPengiriman => 15200; // contoh
  int get _totalBayar => _hargaTotal + _biayaPengiriman;

  // ================== API CHECKOUT ==================
  Future<void> _submitCheckout() async {
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);

    try {
      // 1. Ambil token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        // belum login / token hilang
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Silakan login terlebih dahulu.')),
        );
        return;
      }

      // 2. Siapkan body request
      const String baseUrl = 'http://10.0.2.2:8000/api';
      final uri = Uri.parse('$baseUrl/pesanans');

      final now = DateTime.now();
      final formattedNow =
          '${now.year.toString().padLeft(4, '0')}-'
          '${now.month.toString().padLeft(2, '0')}-'
          '${now.day.toString().padLeft(2, '0')} '
          '${now.hour.toString().padLeft(2, '0')}:'
          '${now.minute.toString().padLeft(2, '0')}:'
          '${now.second.toString().padLeft(2, '0')}';

      final body = {
        'metode_pembayaran': _selectedPaymentCode,
        'alamat_pengiriman': _alamatUtama,

        // ⬇️ tambahkan field yang diminta Laravel
        'total_harga': _totalBayar,

        // kalau di DB status_pesanan bertipe TINYINT, pakai angka:
        // misal: 0 = baru, 1 = diproses, 2 = selesai
        'status_pesanan': 'dikirim', // <-- ganti 1 jadi kode yang kamu inginkan

        // waktu_pesanan pakai format DATETIME MySQL
        'waktu_pesanan': formattedNow,

        'items': widget.items.map((e) => e.toJson()).toList(),
      };

      // 3. Kirim request dengan header Authorization
      final res = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // <-- INI YANG WAJIB
        },
        body: jsonEncode(body),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        // sukses → pindah ke halaman "Transaksi Berhasil"
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => CheckoutSuccessPage(),
          ),
        );
      } else {
        print('STATUS: ${res.statusCode}');
        print('BODY: ${res.body}');

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal checkout (${res.statusCode})')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  // ================== BOTTOM SHEET METODE PEMBAYARAN ==================
  void _showPaymentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        String tempSelected = _selectedPaymentCode;

        return StatefulBuilder(
          builder: (context, setModalState) {
            Widget buildRadioTile(
              String code,
              String title,
              String? subtitle,
            ) {
              return RadioListTile<String>(
                value: code,
                groupValue: tempSelected,
                onChanged: (val) {
                  setModalState(() => tempSelected = val!);
                  setState(() {
                    _selectedPaymentCode = val!;
                    _selectedPaymentLabel = title;
                  });
                  Navigator.pop(context);
                },
                title: Text(
                  title,
                  style: const TextStyle(fontSize: 14),
                ),
                subtitle: subtitle == null
                    ? null
                    : Text(
                        subtitle,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
              );
            }

            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.85,
              minChildSize: 0.5,
              maxChildSize: 0.95,
              builder: (_, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pilih Metode Pembayaran',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        // Dompet Digital
                        const SizedBox(height: 8),
                        const Text(
                          'Dompet Digital',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const Divider(),
                        buildRadioTile('gopay', 'Gopay (Rp.150.000)', null),
                        buildRadioTile(
                          'ovo',
                          'OVO',
                          'Aktifkan pembayaran ini dulu, yuk!',
                        ),
                        buildRadioTile('dana', 'DANA (Rp.500.000)', null),

                        const SizedBox(height: 12),
                        const Text(
                          'Bayar di Tempat',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const Divider(),
                        buildRadioTile(
                          'cod',
                          'COD (Bayar di Tempat)',
                          'Tidak Tersedia untuk Transaksi Ini',
                        ),

                        const SizedBox(height: 12),
                        const Text(
                          'Virtual Account',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const Divider(),
                        buildRadioTile('bca_va', 'BCA Virtual Account', null),
                        buildRadioTile(
                            'mandiri_va', 'Mandiri Virtual Account', null),
                        buildRadioTile('bni_va', 'BNI Virtual Account', null),
                        buildRadioTile('btn_va', 'BTN Virtual Account', null),
                        buildRadioTile('bsi_va', 'BSI Syariah Indonesia', null),

                        const SizedBox(height: 12),
                        const Text(
                          'Transfer Bank',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const Divider(),
                        buildRadioTile('bca_tf', 'Transfer Bank BCA', null),
                        buildRadioTile('bsi_tf', 'Transfer Bank BSI', null),
                        buildRadioTile('btn_tf', 'Transfer Bank BTN', null),
                        buildRadioTile('bni_tf', 'Transfer Bank BNI', null),
                        buildRadioTile(
                            'mandiri_tf', 'Transfer Bank Mandiri', null),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  // ================== BUILD UI ==================
  @override
  Widget build(BuildContext context) {
    final firstItem = widget.items.isNotEmpty ? widget.items.first : null;

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          firstItem?.namaMenu ?? 'Checkout',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Icon(Icons.share_outlined, color: Colors.black54),
          SizedBox(width: 12),
          Icon(Icons.person_add_alt_1_outlined, color: Colors.black54),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 4),
                _buildPengirimanSection(),
                const SizedBox(height: 4),
                _buildAlamatSection(),
                const SizedBox(height: 8),
                _buildMenuSection(firstItem),
                const SizedBox(height: 8),
                _buildTambahLagiSection(),
                const SizedBox(height: 8),
                _buildRingkasanPembayaranSection(),
                const SizedBox(height: 8),
                _buildMetodePembayaranSection(),
                const SizedBox(height: 16),
              ],
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildPengirimanSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xffe8f4ff),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.delivery_dining,
              color: Color(0xff1fb6ff),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pengiriman',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Pengiriman dalam 26 menit',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlamatSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Alamat Pengiriman',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  _alamatUtama,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CustomAlamatPage(),
                    ),
                  );
                },
                child: const Text(
                  'Ganti Alamat',
                  style: TextStyle(
                    color: Color(0xff1fb6ff),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(CartItem? firstItem) {
    if (firstItem == null) {
      return const SizedBox.shrink();
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // judul menu utama
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstItem.namaMenu,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      firstItem.deskripsi,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 6),
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        side: const BorderSide(color: Colors.black26),
                      ),
                      child: const Text(
                        'Edit',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  firstItem.imageUrl,
                  width: 80,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80,
                    height: 70,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.fastfood),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildPromoCard(
                  label: '25% OFF',
                  title: 'Martabak telor 2',
                  subtitle: '3 ayam 2 telur',
                ),
                const SizedBox(width: 8),
                _buildPromoCard(
                  label: 'PROMO',
                  title: 'Martabak Special',
                  subtitle: '8 varian rasa menjadi 1',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCard({
    required String label,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: 230,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 26,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 11.5,
                color: Colors.black54,
              ),
            ),
          ),
          const Spacer(),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildTambahLagiSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ada lagi yang mau dibeli?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Masih bisa nambah menu lain, ya.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // kembali ke homepage, cart tetap disimpan oleh state global kamu
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Homepage()),
              );
            },
            child: const Text(
              'Tambah',
              style: TextStyle(
                color: Color(0xff1fb6ff),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRingkasanPembayaranSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ringkasan Pembayaran',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            child: Column(
              children: [
                _rowPrice(
                  'Harga',
                  _hargaTotal,
                  hargaCoret: _hargaTotal + 23000,
                ),
                const SizedBox(height: 6),
                _rowPrice(
                  'Biaya Penanganan dan Pengiriman',
                  _biayaPengiriman,
                ),
                const Divider(height: 16),
                _rowPrice(
                  'Total Pembayaran',
                  _totalBayar,
                  isBold: true,
                  highlight: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowPrice(
    String label,
    int harga, {
    bool isBold = false,
    bool highlight = false,
    int? hargaCoret,
  }) {
    final styleBase = TextStyle(
      fontSize: 13,
      color: highlight ? const Color(0xff1fb6ff) : Colors.black87,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13)),
        Row(
          children: [
            if (hargaCoret != null)
              Text(
                _formatRupiah(hargaCoret),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black38,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            if (hargaCoret != null) const SizedBox(width: 4),
            Text(
              _formatRupiah(harga),
              style: styleBase,
            ),
          ],
        ),
      ],
    );
  }

  String _formatRupiah(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      buffer.write(s[i]);
      count++;
      if (count == 3 && i != 0) {
        buffer.write('.');
        count = 0;
      }
    }
    return buffer.toString().split('').reversed.join();
  }

  Widget _buildMetodePembayaranSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.items.isNotEmpty ? widget.items.first.namaMenu : 'Pesanan',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.credit_card, size: 20, color: Colors.black54),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$_selectedPaymentLabel - ${_formatRupiah(_totalBayar)}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: _showPaymentSheet,
                icon: const Icon(Icons.more_horiz, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submitCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1fb6ff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Beli dan Antar Sekarang',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Yay! Kamu hemat 11.000 untuk pembelian ini.',
            style: TextStyle(
              fontSize: 11,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}