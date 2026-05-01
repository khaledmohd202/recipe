import 'package:flutter/material.dart';
import 'package:recipe/core/common/widgets/app_list_fallback_widget.dart';

class AppGridView extends StatelessWidget {
  const AppGridView({
    required this.itemCount,
    required this.itemBuilder,
    super.key,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 12,
    this.mainAxisSpacing = 12,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.isLoading = false,
    this.loadingItemCount = 6,
    this.skeletonBuilder,
    this.emptyWidget,
    this.errorWidget,
    this.hasError = false,
    this.mainAxisExtent,
    this.scrollController,
    this.onRefresh,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool isLoading;
  final int loadingItemCount;
  final IndexedWidgetBuilder? skeletonBuilder;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final bool hasError;
  final double? mainAxisExtent;
  final ScrollController? scrollController;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    if (isLoading && skeletonBuilder != null) {
      return _buildGrid(loadingItemCount, skeletonBuilder!);
    }
    if (hasError) {
      return errorWidget ?? const DefaultErrorWidget();
    }
    if (!isLoading && itemCount == 0) {
      return emptyWidget ?? const DefaultEmptyWidget();
    }
    final grid = _buildGrid(itemCount, itemBuilder);
    if (onRefresh != null) {
      return RefreshIndicator(onRefresh: onRefresh!, child: grid);
    }
    return grid;
  }

  Widget _buildGrid(int count, IndexedWidgetBuilder builder) {
    return GridView.builder(
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      physics:
          physics ?? (shrinkWrap ? const NeverScrollableScrollPhysics() : null),
      padding: padding ?? const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemCount: count,
      itemBuilder: builder,
    );
  }
}
