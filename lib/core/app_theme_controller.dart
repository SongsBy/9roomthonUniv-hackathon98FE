// lib/core/app_theme_controller.dart
import 'package:flutter/material.dart';

class AppThemeController extends ChangeNotifier {
  AppThemeController({Color? initial})
      : _accent = initial ?? const Color(0xFF6D7AC9);

  Color _accent;

  // 현재 테마 (accent 바꾸면 ThemeData도 같이 재생성)
  ThemeData get theme {
    final seed = _accent;
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: seed),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      fontFamily: 'Pretendard',
    );
  }

  Color get accent => _accent;

  void setAccent(Color color) {
    if (color.value == _accent.value) return;
    _accent = color;
    notifyListeners();
  }
}