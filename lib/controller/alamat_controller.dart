import 'package:flutter/material.dart';

class AlamatData {
  String nama = '';
  String nomor = '';
  String alamat = '';
  String catatan = '';
}

class AlamatController extends ChangeNotifier {
  final data = AlamatData();

  void setNama(String value) {
    data.nama = value;
    notifyListeners();
  }

  void setNomor(String value) {
    data.nomor = value;
    notifyListeners();
  }

  void setAlamat(String value) {
    data.alamat = value;
    notifyListeners();
  }

  void setCatatan(String value) {
    data.catatan = value;
    notifyListeners();
  }
}
