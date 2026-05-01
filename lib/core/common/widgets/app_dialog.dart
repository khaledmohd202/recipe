import 'package:flutter/material.dart';

/// App-wide Dialog helpers.
///
/// Usage:
/// ```dart
/// Simple confirm dialog
/// final confirmed = await AppDialog.confirm(
///   context,
///   title: 'Delete Item',
///   message: 'Are you sure you want to delete this item?',
///   confirmText: 'Delete',
///   isDestructive: true,
/// );
/// if (confirmed == true) _deleteItem();
///
/// Info dialog
/// await AppDialog.info(
///   context,
///   title: 'Update Available',
///   message: 'A new version is ready. Please update to continue.',
/// );
///
/// Custom bottom sheet dialog
/// AppDialog.bottomSheet(
///   context,
///   child: YourCustomWidget(),
/// );
///
/// Loading dialog
/// AppDialog.showLoading(context, message: 'Processing...');
/// // ...later
/// AppDialog.hideLoading(context);
/// ```
abstract class AppDialog {
  // ── Confirm ───────────────────────────────────────────

  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
    Widget? icon,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => _AppConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        isDestructive: isDestructive,
        icon: icon,
      ),
    );
  }

  // ── Info ──────────────────────────────────────────────

  static Future<void> info(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'Got it',
    Widget? icon,
  }) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => _AppInfoDialog(
        title: title,
        message: message,
        buttonText: buttonText,
        icon: icon,
      ),
    );
  }

  // ── Custom ────────────────────────────────────────────

  static Future<T?> custom<T>(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
    double? maxWidth,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth ?? 420),
          child: child,
        ),
      ),
    );
  }

  // ── Bottom Sheet ──────────────────────────────────────

  static Future<T?> bottomSheet<T>(
    BuildContext context, {
    required Widget child,
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool showDragHandle = true,
    double? maxHeight,
    Color? backgroundColor,
    double borderRadius = 24,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      showDragHandle: showDragHandle,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(borderRadius)),
      ),
      constraints: maxHeight != null
          ? BoxConstraints(maxHeight: maxHeight)
          : null,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: child,
        ),
      ),
    );
  }

  // ── Loading ───────────────────────────────────────────

  static void showLoading(BuildContext context, {String? message}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => PopScope(
        canPop: false,
        child: _AppLoadingDialog(message: message),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    if (Navigator.canPop(context)) Navigator.of(context).pop();
  }
}

// ─────────────────────────────────────────
// Internal dialog widgets
// ─────────────────────────────────────────

class _AppConfirmDialog extends StatelessWidget {
  const _AppConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    required this.isDestructive,
    this.icon,
  });

  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final bool isDestructive;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      icon: icon,
      title: Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
      content: Text(message, style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7))),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: colorScheme.outline),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(0, 44),
          ),
          child: Text(cancelText),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: isDestructive ? colorScheme.error : colorScheme.primary,
            foregroundColor: isDestructive ? colorScheme.onError : colorScheme.onPrimary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(0, 44),
            elevation: 0,
          ),
          child: Text(confirmText),
        ),
      ],
    );
  }
}

class _AppInfoDialog extends StatelessWidget {
  const _AppInfoDialog({
    required this.title,
    required this.message,
    required this.buttonText,
    this.icon,
  });

  final String title;
  final String message;
  final String buttonText;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      icon: icon,
      title: Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
      content: Text(message, style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7))),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              minimumSize: const Size(0, 44),
              elevation: 0,
            ),
            child: Text(buttonText),
          ),
        ),
      ],
    );
  }
}

class _AppLoadingDialog extends StatelessWidget {
  const _AppLoadingDialog({this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: colorScheme.primary),
            if (message != null) ...[
              const SizedBox(height: 20),
              Text(
                message!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
