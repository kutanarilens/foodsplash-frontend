import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/menu_item.dart';

class MenuService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<MenuItem>> fetchNearestMenus() async {
    final url = Uri.parse('$baseUrl/menus');
    final res = await http.get(url, headers: {'Accept': 'application/json'});

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body);
      final list = (data is List) ? data : (data['data'] ?? []);
      return List<MenuItem>.from(list.map((x) => MenuItem.fromJson(x)));
    } else {
      throw Exception('Gagal memuat menu (${res.statusCode})');
    }
  }
}