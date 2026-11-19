import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';

class HomeScreenProvider extends ChangeNotifier {
  int _selectedNavIndex = 0;
  String _shopName = 'Loading...';
  double _todaySaleAmount = 0;
  int _todayBills = 0;
  int _totalProductsCount = 0;
  List _lowStockItems = [];

  //getter
  int get navIndexes => _selectedNavIndex;
  String get shopName => _shopName;
  int get todayBills => _todayBills;
  int get totalProductsCounts => _totalProductsCount;
  double get salseAmount => _todaySaleAmount;
  List get lowStockItems => _lowStockItems;

  StreamSubscription? _shopSub;
  StreamSubscription? _productsSub;
  StreamSubscription? _billsSub;

  HomeScreenProvider() {
    initLiveFireBaseData();
  }

  void changeNavIndex(int index) {
    if (_selectedNavIndex == index) return;
    _selectedNavIndex = index;
    notifyListeners();
  }

  void initLiveFireBaseData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    //fetch shop name from firestore
    final shopRef = FirebaseFirestore.instance.collection('shop').doc(user.uid);
    _shopSub = shopRef.snapshots().listen((doc) {
      if (doc.exists && doc.data() != null) {
        _shopName = doc.data()!['ShopName'] ?? 'Meri Dukann';
        notifyListeners();
      }
    });

    _productsSub = shopRef.collection('products').snapshots().listen((
      snapshot,
    ) {
      _totalProductsCount = snapshot.docs.length;
      final List lowStock = [];
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final int stock = (data['stock'] ?? 0) is int
            ? data['stock']
            : int.tryParse(data['stock'].toString()) ?? 0;

        if (stock <= 5) {
          lowStock.add({
            'id': doc.id,
            'name': data['name'] ?? 'Unnamed Item',
            'count': stock,
          });
        }
      }
      _lowStockItems = lowStock;
      notifyListeners();
    });

    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);

    _billsSub = shopRef
        .collection('bills')
        .where(
          'createdAt',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfToday),
        )
        .snapshots()
        .listen((snapshot) {
          double total = 0;
          for (var doc in snapshot.docs) {
            final data = doc.data();
            final num amount = data['totalAmount'] ?? 0;
            total += amount.toDouble();
          }
          _todaySaleAmount = total;
          _todayBills = snapshot.docs.length;
          notifyListeners();
        });
  }

  String formatCurrency(double amount) {
    final intVal = amount.toInt().toString();
    return intVal.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  void dispose() {
    _shopSub?.cancel();
    _productsSub?.cancel();
    _billsSub?.cancel();
    super.dispose();
  }
}
