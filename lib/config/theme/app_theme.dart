import 'package:flutter/material.dart';

const Color _customColor = Color(0xFF5C11D4);

const List<Color> _colorThemes = [
  _customColor,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.red,
  Colors.teal,
];

class AppTheme {
  final int selectedColor;

  AppTheme({
    this.selectedColor = 0,
  }): assert(selectedColor >= 0 && selectedColor <= _colorThemes.length - 1);

  // Método que va a construir el tema
  ThemeData theme() {
    return ThemeData(
      useMaterial3: true, 
      colorSchemeSeed: _colorThemes[selectedColor],
      // brightness: Brightness.dark, //tema oscuro
    );
  }
}
