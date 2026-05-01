import 'package:flutter/material.dart';

/// A customizable app-wide ListTile with consistent styling.
///
/// Usage:
/// ```dart
/// AppListTile(
///   title: 'Profile',
///   subtitle: 'Manage your account',
///   leadingIcon: Icons.person_outline,
///   trailingIcon: Icons.chevron_right,
///   onTap: () {},
/// )
///
/// // With custom leading widget (e.g. avatar)
/// AppListTile(
///   title: 'John Doe',
///   subtitle: 'john@example.com',
///   leading: AppImage.circle(imageUrl: user.avatar, size: 44),
///   onTap: () {},
/// )
///
/// // With badge / trailing widget
/// AppListTile(
///   title: 'Notifications',
///   leadingIcon: Icons.notifications_outlined,
///   trailing: Badge.count(count: 3, child: Icon(Icons.notifications)),
/// )
/// ```
class AppListTile extends StatelessWidget {
  const AppListTile({
    required this.title,
    super.key,
    this.subtitle,
    this.leading,
    this.trailing,
    this.leadingIcon,
    this.trailingIcon,
    this.leadingIconColor,
    this.leadingBackgroundColor,
    this.leadingIconSize = 20,
    this.leadingContainerSize = 42,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.borderRadius = 12,
    this.showDivider = false,
    this.isDestructive = false,
    this.contentPadding,
    this.titleStyle,
    this.subtitleStyle,
    this.minVerticalPadding,
    this.enabled = true,
    this.selected = false,
  });

  final String title;
  final String? subtitle;

  final Widget? leading;
  final Widget? trailing;

  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Color? leadingIconColor;
  final Color? leadingBackgroundColor;
  final double leadingIconSize;
  final double leadingContainerSize;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final Color? backgroundColor;
  final double borderRadius;
  final bool showDivider;
  final bool isDestructive;
  final EdgeInsetsGeometry? contentPadding;

  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double? minVerticalPadding;
  final bool enabled;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final destructiveColor = colorScheme.error;
    final effectiveTitleColor = isDestructive
        ? destructiveColor
        : selected
            ? colorScheme.primary
            : colorScheme.onSurface;

    Widget? leadingWidget = leading;
    if (leadingWidget == null && leadingIcon != null) {
      final iconColor = isDestructive
          ? destructiveColor
          : leadingIconColor ?? colorScheme.primary;
      final bgColor = leadingBackgroundColor ??
          iconColor.withValues(alpha: 0.1);

      leadingWidget = Container(
        width: leadingContainerSize,
        height: leadingContainerSize,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(leadingContainerSize / 3),
        ),
        child: Icon(leadingIcon, color: iconColor, size: leadingIconSize),
      );
    }

    Widget? trailingWidget = trailing;
    if (trailingWidget == null && trailingIcon != null) {
      trailingWidget = Icon(
        trailingIcon,
        color: colorScheme.onSurface.withValues(alpha: 0.4),
        size: 20,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: selected
              ? colorScheme.primary.withValues(alpha: 0.08)
              : backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          child: InkWell(
            onTap: enabled ? onTap : null,
            onLongPress: enabled ? onLongPress : null,
            borderRadius: BorderRadius.circular(borderRadius),
            child: ListTile(
              enabled: enabled,
              selected: selected,
              selectedColor: colorScheme.primary,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              minVerticalPadding: minVerticalPadding,
              leading: leadingWidget,
              title: Text(
                title,
                style: titleStyle ??
                    theme.textTheme.bodyLarge?.copyWith(
                      color: effectiveTitleColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle!,
                      style: subtitleStyle ??
                          theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.55),
                          ),
                    )
                  : null,
              trailing: trailingWidget,
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: leadingWidget != null ? leadingContainerSize + 32 : 16,
            endIndent: 16,
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
      ],
    );
  }
}
