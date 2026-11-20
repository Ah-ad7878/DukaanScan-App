import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';

class ProductProvider extends ChangeNotifier {
  List _allProducts = [];
  String _searchQuery = '';
  String _selectedFilter = 'Sab';
  bool _isLoading = false;

  StreamSubscription? _productsSub;

  List<dynamic> get allProducts => _allProducts;
  String get selectedFilter => _selectedFilter;
  bool get isLoading => _isLoading;
  int get totalCount => _allProducts.length;

  int get lowStockCount =>
      _allProducts.where((p) => (p['stock'] as int) <= 5).length;

  List<dynamic> get filteredProducts {
    return _allProducts.where((product) {
      final String name = (product['name'] ?? '').toString().toLowerCase();
      final String barcode = (product['barcode'] ?? '')
          .toString()
          .toLowerCase();
      final String category = (product['category'] ?? 'Kiryana').toString();
      final int stock = product['stock'] ?? 0;

      final matchesSearch =
          _searchQuery.isEmpty ||
          name.contains(_searchQuery) ||
          barcode.contains(_searchQuery);

      if (!matchesSearch) return false;

      if (_selectedFilter == 'Kam stock') {
        return stock <= 5;
      } else if (_selectedFilter == 'Kiryana') {
        return category == 'Kiryana';
      }
      return true;
    }).toList();
  }

  ProductProvider() {
    initProductsStream();
  }

  void initProductsStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _productsSub = FirebaseFirestore.instance
        .collection('shop')
        .doc(user.uid)
        .collection('products')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
          _allProducts = snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'id': doc.id,
              'name': data['name'] ?? '',
              'barcode': data['barcode'] ?? '',
              'price': (data['price'] ?? 0).toDouble(),
              'stock': (data['stock'] ?? 0) is int
                  ? data['stock']
                  : int.tryParse(data['stock'].toString()) ?? 0,
              'category': data['category'] ?? 'Kiryana',
            };
          }).toList();
          notifyListeners();
        });
  }

  void updateSearch(String query) {
    _searchQuery = query.trim().toLowerCase();
    notifyListeners();
  }

  void changeFilter(String filter) {
    if (_selectedFilter == filter) return;
    _selectedFilter = filter;
    notifyListeners();
  }

  Future<bool> addProduct({
    required String name,
    required String barcode,
    required double price,
    required int stock,
    String category = 'Kiryana',
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      await FirebaseFirestore.instance
          .collection('shop')
          .doc(user.uid)
          .collection('products')
          .add({
            'name': name.trim(),
            'barcode': barcode.trim(),
            'price': price,
            'stock': stock,
            'category': category,
            'createdAt': FieldValue.serverTimestamp(),
          });
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> updateStock(String productId, int newStock) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || newStock < 0) return;

    await FirebaseFirestore.instance
        .collection('shop')
        .doc(user.uid)
        .collection('products')
        .doc(productId)
        .update({'stock': newStock});
  }

  Future<void> deleteProduct(String productId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('shop')
        .doc(user.uid)
        .collection('products')
        .doc(productId)
        .delete();
  }

  @override
  void dispose() {
    _productsSub?.cancel();
    super.dispose();
  }
}
