import 'dart:convert';
import 'package:foodsplash/models/restoran_data.dart';
import 'package:http/http.dart' as http;
import '../models/menu_item.dart';

class RestoService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<RestoranData>> fetchNearestResto() async {
    final url = Uri.parse('$baseUrl/restoran');
    final res = await http.get(url, headers: {'Accept': 'application/json'});

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body);
      final list = (data is List) ? data : (data['data'] ?? []);
      return List<RestoranData>.from(list.map((x) => MenuItem.fromJson(x)));
    } else {
      throw Exception('Gagal memuat restoran (${res.statusCode})');
    }
  }
}
