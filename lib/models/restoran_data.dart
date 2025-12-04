class RestoranData {
  final int id;
  final String nama;
  final String alamat;
  final String noTelepon;
  final String? deskripsi;
  final String jadwalOperasional;
  final String kategori;
  // final int menu_id;
  // final int pesanan_id;
  // final int ulasan_id;

  RestoranData({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.noTelepon,
    this.deskripsi,
    required this.jadwalOperasional,
    required this.kategori,
    // required this.menu_id,
    // required this.pesanan_id,
    // required this.ulasan_id,
  });

  factory RestoranData.fromJson(Map<String, dynamic> j) {
    double? _toDouble(dynamic v) =>
        v == null ? null : (v is num ? v.toDouble() : double.tryParse('$v'));

    return RestoranData(
      id: j['id'] as int,
      nama: j['nama'] as String,
      alamat: j['alamat'] as String,
      deskripsi: j['deskripsi'] as String?,
      jadwalOperasional: j['jadwal_operasional'] as String,
      kategori: j['kategori_menu_restoran'] as String,
      noTelepon: j['no_telepon'] as String,
      // status: j['status_ketersediaan_stok'] as String? ?? 'tersedia',
      // avgRating: _toDouble(j['avg_rating']),
      // reviewsCount: (j['reviews_count'] is int)
      //     ? j['reviews_count'] as int
      //     : int.tryParse('${j['reviews_count'] ?? 0}'),
      // imageUrl: j['image_url'] as String?,
      // jarak: j['jarak'] as int?,
    );
  }
}
