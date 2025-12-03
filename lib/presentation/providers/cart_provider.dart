import 'package:flutter/material.dart';
import '../../data/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  final List<CartItem> _orders = []; // Simulating order history

  List<CartItem> get items => _items;
  List<CartItem> get orders => _orders;

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Move items from cart to orders
  void checkout() {
    for (var item in _items) {
      // Create a new item with 'Booked' status
      _orders.add(CartItem(
        id: item.id,
        serviceName: item.serviceName,
        price: item.price,
        date: item.date,
        time: item.time,
        status: 'Booked',
      ));
    }
    _items.clear();
    notifyListeners();
  }
}
