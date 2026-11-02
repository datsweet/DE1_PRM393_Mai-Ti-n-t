import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/theme_preferences.dart';

part 'theme_viewmodel.g.dart';

@riverpod
class ThemeViewModel extends _$ThemeViewModel {
  @override
  Color build() {
    _loadSavedColor();
    return ThemePreferences.defaultColor;
  }

  Future<void> _loadSavedColor() async {
    final savedColor = await ThemePreferences.getAppBarColor();
    state = savedColor;
  }

  Future<void> changeAppBarColor(Color newColor) async {
    state = newColor;
    await ThemePreferences.saveAppBarColor(newColor);
  }
}

