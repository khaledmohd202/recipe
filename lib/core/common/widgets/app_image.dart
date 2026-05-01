import 'package:flutter/material.dart';

/// A smart image widget that handles network, asset, and file images
/// with built-in loading placeholder and error fallback.
///
/// Usage:
/// ```dart
/// Network image
/// AppImage(
///   imageUrl: 'https://example.com/image.jpg',
///   width: 200,
///   height: 200,
///   fit: BoxFit.cover,
/// )
///
/// Circular avatar
/// AppImage.circle(
///   imageUrl: user.avatarUrl,
///   size: 48,
/// )
///
/// Asset image
/// AppImage.asset(
///   assetPath: 'assets/images/banner.png',
///   width: double.infinity,
///   height: 180,
/// )
/// ```
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorWidget,
    this.loadingWidget,
    this.backgroundColor,
    this.border,
    this.shape = BoxShape.rectangle,
    // ignore: unused_element
    bool isAsset = false,
  }) : _isAsset = isAsset,
       assetPath = null,
       size = null;

  const AppImage.circle({
    super.key,
    this.imageUrl,
    required double this.size,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.loadingWidget,
    this.backgroundColor,
    this.border,
  }) : _isAsset = false,
       assetPath = null,
       width = size,
       height = size,
       borderRadius = null,
       shape = BoxShape.circle;

  const AppImage.asset({
    super.key,
    required String this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorWidget,
    this.loadingWidget,
    this.backgroundColor,
    this.border,
    this.shape = BoxShape.rectangle,
  }) : _isAsset = true,
       imageUrl = null,
       size = null;

  final String? imageUrl;
  final String? assetPath;
  final double? width;
  final double? height;
  final double? size;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Color? backgroundColor;
  final BoxBorder? border;
  final BoxShape shape;
  final bool _isAsset;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final defaultBg = backgroundColor ?? colorScheme.surfaceContainerHighest;

    Widget imageWidget;

    if (_isAsset && assetPath != null) {
      imageWidget = Image.asset(
        assetPath!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildError(context),
      );
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      imageWidget = Image.network(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return loadingWidget ?? _buildLoading(context, loadingProgress);
        },
        errorBuilder: (context, error, stackTrace) => _buildError(context),
      );
    } else {
      imageWidget = _buildError(context);
    }

    // Apply shape clipping
    if (shape == BoxShape.circle || borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: shape == BoxShape.circle
            ? BorderRadius.circular(
                (size ?? ((width ?? 0) + (height ?? 0)) / 2) / 2,
              )
            : (borderRadius as BorderRadius? ?? BorderRadius.zero),
        child: imageWidget,
      );
    }

    if (border != null || backgroundColor != null) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: defaultBg,
          shape: shape,
          borderRadius: shape == BoxShape.circle
              ? null
              : borderRadius as BorderRadius?,
          border: border,
        ),
        child: ClipRRect(
          borderRadius: shape == BoxShape.circle
              ? BorderRadius.circular((size ?? 0) / 2)
              : (borderRadius as BorderRadius? ?? BorderRadius.zero),
          child: (_isAsset && assetPath != null)
              ? Image.asset(
                  assetPath!,
                  fit: fit,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildError(context),
                )
              : (imageUrl != null && imageUrl!.isNotEmpty)
              ? Image.network(
                  imageUrl!,
                  fit: fit,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return loadingWidget ?? _buildLoading(context, progress);
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      _buildError(context),
                )
              : _buildError(context),
        ),
      );
    }

    return imageWidget;
  }

  Widget _buildLoading(BuildContext context, ImageChunkEvent progress) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            value: progress.expectedTotalBytes != null
                ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                : null,
            color: colorScheme.primary.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (errorWidget != null) return errorWidget!;
    return Container(
      width: width,
      height: height,
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: colorScheme.onSurface.withValues(alpha: 0.35),
          size: _iconSize,
        ),
      ),
    );
  }

  double get _iconSize {
    final s = size ?? ((width ?? 60) + (height ?? 60)) / 2;
    if (s < 40) return 16;
    if (s < 80) return 24;
    return 32;
  }
}
