import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
  }) : _isAsset = false,
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
      // CachedNetworkImage
      imageWidget = CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => loadingWidget ?? _buildLoading(context),
        errorWidget: (context, url, error) => _buildError(context),
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
          child: _isAsset && assetPath != null
              // Local asset
              ? Image.asset(
                  assetPath!,
                  fit: fit,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildError(context),
                )
              : imageUrl != null && imageUrl!.isNotEmpty
              // Network — CachedNetworkImage
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: fit,
                  placeholder: (context, url) =>
                      loadingWidget ?? _buildLoading(context),
                  errorWidget: (context, url, error) => _buildError(context),
                )
              : _buildError(context),
        ),
      );
    }

    return imageWidget;
  }

  Widget _buildLoading(BuildContext context) {
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
