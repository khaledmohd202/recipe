import 'package:flutter/material.dart';

abstract class AppColors {
  // ── Primary ───────────────────────────────────
  static const Color primary = Color(0xFFE53935);
  static const Color primaryLight = Color(0xFFFF7043);

  // ── Light Mode ────────────────────────────────
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF5F5F5);
  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightCardBg = Color(0xFFFFFFFF);

  // ── Dark Mode ─────────────────────────────────
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF9E9E9E);
  static const Color darkBorder = Color(0xFF2C2C2C);
  static const Color darkCardBg = Color(0xFF1E1E1E);
}
