class CartItem {
  final int id;
  final String namaMenu;
  final String deskripsi;
  final String imageUrl;
  final int qty;
  final int harga;

  CartItem({
    required this.id,
    required this.namaMenu,
    required this.deskripsi,
    required this.imageUrl,
    required this.qty,
    required this.harga,
  });

  int get subtotal => qty * harga;

  Map<String, dynamic> toJson() {
    return {
      'menu_id': id,
      'qty': qty,
      'harga': harga,
    };
  }
}