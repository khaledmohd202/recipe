import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe/core/extension/context_extension.dart';

/// A fully customizable app-wide TextFormField.
///
/// Usage:
/// ```dart
/// AppTextField(
///   label: 'Email',
///   hintText: 'Enter your email',
///   controller: _emailController,
///   keyboardType: TextInputType.emailAddress,
///   prefixIcon: Icons.email_outlined,
///   validator: (v) => v!.isEmpty ? 'Required' : null,
/// )
///
/// Password field
/// AppTextField(
///   label: 'Password',
///   controller: _passController,
///   isPassword: true,
///   prefixIcon: Icons.lock_outline,
/// )
///
///Read-only (display)
/// AppTextField(
///   label: 'Category',
///   controller: _catController,
///   readOnly: true,
///   suffixIcon: Icons.expand_more,
///   onTap: _showPicker,
/// )
/// ```
class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.controller,
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixWidget,
    this.prefixWidget,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.focusNode,
    this.nextFocusNode,
    this.isPassword = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor = Colors.red,
    this.borderRadius = 12,
    this.contentPadding,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.showCounter = false,
  });

  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final String? helperText;

  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final Widget? prefixWidget;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;

  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  final bool isPassword;
  final bool readOnly;
  final bool enabled;

  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color errorBorderColor;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final bool showCounter;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveBorderColor = widget.borderColor ?? colorScheme.outline;
    final effectiveFocusedBorderColor =
        widget.focusedBorderColor ?? colorScheme.primary;
    final effectiveFillColor =
        widget.fillColor ??
        colorScheme.surfaceContainerHighest.withValues(alpha: 0.4);

    OutlineInputBorder buildBorder(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: color, width: 1.5),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: theme.textTheme.labelLarge?.copyWith(
              color: context.colorScheme.onSurface,
              // color: Colors.black45,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.nextFocusNode != null
              ? TextInputAction.next
              : widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          obscureText: _obscureText,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          textCapitalization: widget.textCapitalization,
          autofillHints: widget.autofillHints,
          cursorColor: effectiveFocusedBorderColor,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onFieldSubmitted: (value) {
            if (widget.nextFocusNode != null) {
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            }
            widget.onFieldSubmitted?.call(value);
          },
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            helperText: widget.helperText,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.45),
              fontWeight: FontWeight.w400,
            ),
            helperStyle: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            errorStyle: theme.textTheme.bodySmall?.copyWith(
              color: widget.errorBorderColor,
            ),
            filled: true,
            fillColor: widget.enabled
                ? effectiveFillColor
                : colorScheme.onSurface.withValues(alpha: 0.08),
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            counterText: widget.showCounter ? null : '',

            // Prefix
            prefixIcon:
                widget.prefixWidget ??
                (widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color: colorScheme.onSurface.withValues(alpha: 0.55),
                        size: 20,
                      )
                    : null),

            // Suffix
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: colorScheme.onSurface.withValues(alpha: 0.55),
                      size: 20,
                    ),
                  )
                : widget.suffixWidget ??
                      (widget.suffixIcon != null
                          ? Icon(
                              widget.suffixIcon,
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.55,
                              ),
                              size: 20,
                            )
                          : null),

            // Borders
            border: buildBorder(effectiveBorderColor),
            enabledBorder: buildBorder(effectiveBorderColor),
            focusedBorder: buildBorder(effectiveFocusedBorderColor),
            errorBorder: buildBorder(widget.errorBorderColor),
            focusedErrorBorder: buildBorder(widget.errorBorderColor),
            disabledBorder: buildBorder(
              colorScheme.onSurface.withValues(alpha: 0.2),
            ),
          ),
        ),
      ],
    );
  }
}
