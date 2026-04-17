import 'package:flutter/material.dart';
import '/root/theme.dart';
import '/ui/splash.dart';

void main() {
  runApp(
    MaterialApp(title: "Funcionários", theme: AppTheme.appTeme, home: Splash())
  );
}