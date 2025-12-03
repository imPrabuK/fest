import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = 'Guest';
  String _contactInfo = ''; // Email or Phone
  String _city = 'Select City';
  bool _isLoggedIn = false;

  String get name => _name;
  String get contactInfo => _contactInfo;
  String get city => _city;
  bool get isLoggedIn => _isLoggedIn;

  void setUserDetails({
    required String name,
    required String contactInfo,
    required String city,
  }) {
    _name = name;
    _contactInfo = contactInfo;
    _city = city;
    _isLoggedIn = true;
    notifyListeners();
  }

  void setContactInfo(String contact) {
    _contactInfo = contact;
    notifyListeners();
  }

  void logout() {
    _name = 'Guest';
    _contactInfo = '';
    _city = 'Select City';
    _isLoggedIn = false;
    notifyListeners();
  }
}
