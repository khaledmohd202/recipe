import 'package:flutter/material.dart';

// ─────────────────────────────────────────
// AppShimmer  — zero extra dependencies
// ─────────────────────────────────────────

/// A shimmer loading effect that works without any extra package.
///
/// Usage:
/// ```dart
/// // Wrap any skeleton layout
/// AppShimmer(
///   child: Column(
///     children: [
///       ShimmerBox(width: double.infinity, height: 180, borderRadius: 16),
///       const SizedBox(height: 12),
///       ShimmerBox(width: 200, height: 18, borderRadius: 6),
///       const SizedBox(height: 8),
///       ShimmerBox(width: 140, height: 14, borderRadius: 6),
///     ],
///   ),
/// )
///
/// // Ready-made card skeleton
/// AppShimmer(child: ShimmerProductCard())
///
/// // Ready-made list item skeleton
/// AppShimmer(child: ShimmerListItem())
/// ```
class AppShimmer extends StatefulWidget {
  const AppShimmer({
    required this.child,
    super.key,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1400),
    this.enabled = true,
  });

  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;
  final bool enabled;

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = widget.baseColor ??
        (isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0));
    final highlight = widget.highlightColor ??
        (isDark ? const Color(0xFF3D3D3D) : const Color(0xFFF5F5F5));

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [base, highlight, base],
              stops: const [0.0, 0.5, 1.0],
              transform: _SlidingGradientTransform(_animation.value),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform(this.slidePercent);
  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
  }
}

// ─────────────────────────────────────────
// ShimmerBox  — the building block
// ─────────────────────────────────────────

/// A simple colored box used as a skeleton placeholder.
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = 8,
    this.color,
  });

  final double? width;
  final double height;
  final double borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? (isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

// ─────────────────────────────────────────
// Ready-made skeletons
// ─────────────────────────────────────────

/// Skeleton for a product / image card
class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key, this.borderRadius = 16});
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(width: double.infinity, height: 140, borderRadius: 0),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(width: double.infinity, height: 14),
                const SizedBox(height: 6),
                ShimmerBox(width: 90, height: 12),
                const SizedBox(height: 10),
                ShimmerBox(width: 60, height: 16),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton for a list item with leading avatar
class ShimmerListItem extends StatelessWidget {
  const ShimmerListItem({super.key, this.hasSubtitle = true});
  final bool hasSubtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const ShimmerBox(width: 48, height: 48, borderRadius: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(width: double.infinity, height: 14),
                if (hasSubtitle) ...[
                  const SizedBox(height: 6),
                  ShimmerBox(width: 160, height: 12),
                ],
              ],
            ),
          ),
          const SizedBox(width: 14),
          const ShimmerBox(width: 40, height: 14, borderRadius: 6),
        ],
      ),
    );
  }
}

/// Skeleton for a simple text block
class ShimmerTextBlock extends StatelessWidget {
  const ShimmerTextBlock({super.key, this.lines = 3});
  final int lines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(lines, (i) {
        final isLast = i == lines - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: i < lines - 1 ? 8 : 0),
          child: ShimmerBox(
            width: isLast ? 180 : double.infinity,
            height: 14,
          ),
        );
      }),
    );
  }
}
