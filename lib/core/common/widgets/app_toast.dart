import 'package:flutter/material.dart';

/// App-wide Toast helper using Flutter's built-in SnackBar.
///
/// Call from anywhere you have a [BuildContext]:
/// ```dart
/// AppToast.success(context, 'Order placed successfully!');
/// AppToast.error(context, 'Something went wrong. Try again.');
/// AppToast.warning(context, 'Low stock — only 2 left.');
/// AppToast.info(context, 'Sync complete.');
///
/// // Custom toast
/// AppToast.show(
///   context,
///   message: 'Item added to cart',
///   icon: Icons.shopping_cart_outlined,
///   backgroundColor: Colors.deepPurple,
/// );
/// ```
abstract class AppToast {
  // ── Convenience constructors ──────────────────────────

  static void success(BuildContext context, String message) => show(
        context,
        message: message,
        icon: Icons.check_circle_outline,
        type: _ToastType.success,
      );

  static void error(BuildContext context, String message) => show(
        context,
        message: message,
        icon: Icons.error_outline,
        type: _ToastType.error,
      );

  static void warning(BuildContext context, String message) => show(
        context,
        message: message,
        icon: Icons.warning_amber_outlined,
        type: _ToastType.warning,
      );

  static void info(BuildContext context, String message) => show(
        context,
        message: message,
        icon: Icons.info_outline,
        type: _ToastType.info,
      );

  // ── Core method ───────────────────────────────────────

  static void show(
    BuildContext context, {
    required String message,
    IconData? icon,
    _ToastType type = _ToastType.info,
    Color? backgroundColor,
    Color? textColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    double? width,
    EdgeInsetsGeometry? margin,
    double borderRadius = 12,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    final resolvedBg = backgroundColor ?? _bgColor(type, colorScheme);
    final resolvedText = textColor ?? _textColor(type, colorScheme);
    final resolvedIcon = icon ?? _icon(type);

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          duration: duration,
          behavior: behavior,
          backgroundColor: resolvedBg,
          width: width,
          margin: margin ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          action: action,
          content: Row(
            children: [
              Icon(resolvedIcon, color: resolvedText, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: resolvedText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  // ── Helpers ───────────────────────────────────────────

  static Color _bgColor(_ToastType type, ColorScheme cs) => switch (type) {
        _ToastType.success => const Color(0xFF1E6B3C),
        _ToastType.error => cs.error,
        _ToastType.warning => const Color(0xFF8A5700),
        _ToastType.info => cs.inverseSurface,
      };

  static Color _textColor(_ToastType type, ColorScheme cs) => switch (type) {
        _ToastType.success => Colors.white,
        _ToastType.error => cs.onError,
        _ToastType.warning => Colors.white,
        _ToastType.info => cs.onInverseSurface,
      };

  static IconData _icon(_ToastType type) => switch (type) {
        _ToastType.success => Icons.check_circle_outline,
        _ToastType.error => Icons.error_outline,
        _ToastType.warning => Icons.warning_amber_outlined,
        _ToastType.info => Icons.info_outline,
      };
}

enum _ToastType { success, error, warning, info }
