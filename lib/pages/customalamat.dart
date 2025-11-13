import 'package:flutter/material.dart';

class CustomAlamatPage extends StatefulWidget {
  const CustomAlamatPage({super.key});

  @override
  State<CustomAlamatPage> createState() => _CustomAlamatPageState();
}

class _CustomAlamatPageState extends State<CustomAlamatPage> {
  final TextEditingController _searchController = TextEditingController();

  // Dummy alamat yang sudah tersedia
  List<Map<String, String>> alamatList = [
    {
      "alamat":
          "Jalan Mawar No. 23, Kelurahan Sukamaju, Kecamatan Sukasari, Kota Bandung, Jawa Barat, 40123",
      "nama": "Budi Santoso",
      "telp": "0812-3456-7890"
    },
    {
      "alamat":
          "Jalan Melati Raya Blok B-12, Perumahan Taman Indah, Kecamatan Pondok Gede, Kota Bekasi, Jawa Barat, 17414",
      "nama": "Siti Aminah",
      "telp": "0813-9876-5432"
    },
    {
      "alamat":
          "Jalan Pahlawan No. 45 RT 03 RW 02, Desa Karangjati, Kecamatan Karanganyar, Kabupaten Kebumen, Jawa Tengah, 54321",
      "nama": "Ahmad Fauzi",
      "telp": "0852-1234-5678"
    },
  ];

  // Filter hasil pencarian
  List<Map<String, String>> get filteredAlamat {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) return alamatList;
    return alamatList
        .where((item) => item["alamat"]!.toLowerCase().contains(query))
        .toList();
  }

  // Tambah/Edit alamat
  void _showInputDialog({Map<String, String>? data, int? index}) {
    final TextEditingController alamatC =
        TextEditingController(text: data?["alamat"] ?? "");
    final TextEditingController namaC =
        TextEditingController(text: data?["nama"] ?? "");
    final TextEditingController telpC =
        TextEditingController(text: data?["telp"] ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(data == null ? "Tambah Alamat" : "Edit Alamat"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: alamatC,
                  decoration: const InputDecoration(labelText: "Alamat"),
                ),
                TextField(
                  controller: namaC,
                  decoration: const InputDecoration(labelText: "Nama"),
                ),
                TextField(
                  controller: telpC,
                  decoration: const InputDecoration(labelText: "No. Telepon"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Batal"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text(data == null ? "Tambah" : "Simpan"),
              onPressed: () {
                if (alamatC.text.isEmpty ||
                    namaC.text.isEmpty ||
                    telpC.text.isEmpty) return;

                if (data == null) {
                  // Tambah alamat
                  setState(() {
                    alamatList.add({
                      "alamat": alamatC.text,
                      "nama": namaC.text,
                      "telp": telpC.text,
                    });
                  });
                } else {
                  // Edit alamat
                  setState(() {
                    alamatList[index!] = {
                      "alamat": alamatC.text,
                      "nama": namaC.text,
                      "telp": telpC.text,
                    };
                  });
                }

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // pilih alamat lalu kembali ke rincian pesan
  void _pilihAlamat(String alamat) {
    Navigator.pop(context, alamat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Pengisian Alamat",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF32B7E8),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // SEARCH BAR
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Cari Lokasi",
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // MAP DUMMY
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(18),
              image: const DecorationImage(
                image: AssetImage("assets/images/dummy_map.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 18),

          // ALAMAT ANTAR (DEFAULT)
          _buildAlamatUtama(),

          const SizedBox(height: 12),

          // Tombol Gunakan Alamat Saat Ini
          ElevatedButton.icon(
            onPressed: () => _pilihAlamat("Jl. Situ Indah No 53, Depok"),
            icon: const Icon(Icons.location_on, color: Colors.white),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF32B7E8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            label: const Text(
              "GUNAKAN ALAMAT SAAT INI",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 20),

          // ===================== DAFTAR ALAMAT =====================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Alamat Tersimpan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () => _showInputDialog(),
                child: const Text(
                  "Tambahkan",
                  style: TextStyle(color: Color(0xFF32B7E8)),
                ),
              ),
            ],
          ),

          ...filteredAlamat.asMap().entries.map((entry) {
            final i = entry.key;
            final data = entry.value;
            return _buildAlamatCard(data, i);
          }),
        ],
      ),
    );
  }

  // ========================= COMPONENTS =========================

  Widget _buildAlamatUtama() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.lightBlue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Antar ke: Jalan Situ Indah No 53, Kel.Tugu, Depok",
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlamatCard(Map<String, String> item, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _pilihAlamat(item["alamat"]!),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item["alamat"]!,
                  style: const TextStyle(fontSize: 12, height: 1.4)),
              const SizedBox(height: 4),
              Text("${item["nama"]} (${item["telp"]})",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _showInputDialog(data: item, index: index),
                  child: const Text(
                    "Ubah",
                    style: TextStyle(fontSize: 12, color: Color(0xFF32B7E8)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
