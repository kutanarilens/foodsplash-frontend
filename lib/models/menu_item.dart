class MenuItem {
  final int id;
  final String namaMenu;
  final String? deskripsi;
  final double harga;
  final String? kategori;
  final String status;
  final double? avgRating;
  final int? reviewsCount;
  final String? imageUrl;
  final int? jarak;

  MenuItem({
    required this.id,
    required this.namaMenu,
    this.deskripsi,
    required this.harga,
    this.kategori,
    required this.status,
    this.avgRating,
    this.reviewsCount,
    this.imageUrl,
    this.jarak,
  });

  factory MenuItem.fromJson(Map<String, dynamic> j) {
    double? _toDouble(dynamic v) =>
        v == null ? null : (v is num ? v.toDouble() : double.tryParse('$v'));

    return MenuItem(
      id: j['id'] as int,
      namaMenu: j['nama_menu'] as String,
      deskripsi: j['deskripsi'] as String?,
      harga: _toDouble(j['harga']) ?? 0.0,
      kategori: j['kategori'] as String?,
      status: j['status_ketersediaan_stok'] as String? ?? 'tersedia',
      avgRating: _toDouble(j['avg_rating']),
      reviewsCount: (j['reviews_count'] is int)
          ? j['reviews_count'] as int
          : int.tryParse('${j['reviews_count'] ?? 0}'),
      imageUrl: j['image_url'] as String?,
      jarak: j['jarak'] as int?,
    );
  }
}
