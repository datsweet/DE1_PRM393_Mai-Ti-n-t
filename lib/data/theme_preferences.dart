import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const String _keyAppBarColor = 'app_bar_color';

  // Màu mặc định ban đầu (xám than sang trọng như ảnh đề bài)
  static const Color defaultColor = Color(0xFF2E3842);

  // Danh sách các màu hỗ trợ theo đúng yêu cầu đề bài:
  // "xanh dương, xanh lá hoặc tím" và các biến thể tương ứng
  static const List<Color> availableColors = [
    Color(0xFF2196F3), 
    Color(0xFF4CAF50), 
    Color(0xFF9C27B0), 
    Color(0xFF3F51B5), 
    Color(0xFF009688), 
    Color(0xFF673AB7), 
    Color(0xFF2E3842), 
    Color(0xFF607D8B), 
  ];

  static Future<void> saveAppBarColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyAppBarColor, color.toARGB32());
  }

  static Future<Color> getAppBarColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorVal = prefs.getInt(_keyAppBarColor);
    if (colorVal != null) {
      return Color(colorVal);
    }
    return defaultColor;
  }
}
