import 'package:flutter/material.dart';
import 'package:foodsplash/pages/homepage.dart';
import 'package:foodsplash/pages/login.dart';
import 'package:foodsplash/layout/data/api_services.dart';
import 'package:foodsplash/pages/promo_page.dart';
import 'package:foodsplash/pages/pesanandiproses.dart';
import 'package:foodsplash/pages/ubah_profil_page.dart';

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
            fontSize: 12,
            color: isActive ? Colors.lightBlue : Colors.grey,
          ),
        ),
        const SizedBox(height: 2),
      ],
    ),
  );
}

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  bool loading = false;
  String? errorMessage;
  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Konfirmasi Logout"),
          content: const Text("Apakah Anda yakin ingin keluar dari akun ini?"),
          actions: <Widget>[
            // Tombol 'Batal'
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup dialog
              },
              child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            ),
            // Tombol 'Logout'
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Tutup dialog
                _performLogout(); // Lanjutkan proses logout
              },
              child: const Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _performLogout() async {
    setState(() {
      loading = true;
      errorMessage = null;
    });

    try {
      final result = await ApiServices.logout();

      if (result["status"] == "success" && mounted) {
        // Navigasi ke halaman login dan hapus semua rute
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
          (Route<dynamic> route) => false,
        );
      } else if (mounted) {
        setState(() {
          errorMessage = result["message"] ?? "Logout gagal.";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = "Terjadi Kesalahan saat Logout: ${e.toString()}";
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  void _submit() async {
    setState(() {
      loading = true;
      errorMessage = null;
    });

    try {
      final result = await ApiServices.logout();

      if (result["status"] == "success" && mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
          (Route<dynamic> route) => false,
        );
      } else if (mounted) {
        setState(() {
          errorMessage = result["message"] ?? "Logout gagal.";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = "Terjadi Kesalahan saat Logout: ${e.toString()}";
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Widget _buildAccountOption(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 24),
            const SizedBox(width: 15),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color.fromARGB(255, 25, 118, 210);
    final name = ApiServices.username;
    final email = ApiServices.userEmail;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Profilku",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "$name",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$email",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Navigasi ke UbahProfilPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UbahProfilPage(
                          initialName: name,
                          initialEmail: email,
                        ),
                      ),
                    ).then((value) {
                      if (value == true) {
                        setState(() {});
                      }
                    });
                  },
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Akun",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            _buildAccountOption(context, Icons.receipt_long, 'Aktivitasku', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PesananDiprosesPage()),
              );
            }),
            _buildAccountOption(
              context,
              Icons.credit_card,
              'Metode Pembayaran',
              () => print('Go to Metode Pembayaran'),
            ),
            _buildAccountOption(
              context,
              Icons.percent_outlined,
              'Promo',
              () => print('Go to Promo'),
            ),
            _buildAccountOption(
              context,
              Icons.language,
              'Pilihan Bahasa',
              () => print('Go to Pilihan Bahasa'),
            ),
            _buildAccountOption(
              context,
              Icons.bookmark_border,
              'Alamat Favorit',
              () => print('Go to Alamat Favorit'),
            ),
            _buildAccountOption(
              context,
              Icons.notifications_none,
              'Notifikasi',
              () => print('Go to Notifikasi'),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : _confirmLogout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
      bottomNavigationBar: const _NavigationMenu(),
    );
  }
}

class _NavigationMenu extends StatelessWidget {
  const _NavigationMenu();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
            _buildNavItem(Icons.article_outlined, 'Aktivitas', false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PesananDiprosesPage()),
              );
            }),
            _buildNavItem(Icons.percent, 'Promo', false, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PromoPage()),
              );
            }),
            _buildNavItem(Icons.person, 'Akun', true, () {}),
          ],
        ),
      ),
    );
  }
}
