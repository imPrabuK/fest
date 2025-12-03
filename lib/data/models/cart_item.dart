import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String serviceName;
  final String price;
  final DateTime date;
  final TimeOfDay time;
  final String status; // 'Pending', 'Booked', 'Completed'

  CartItem({
    required this.id,
    required this.serviceName,
    required this.price,
    required this.date,
    required this.time,
    this.status = 'Pending',
  });
}
