import 'package:flutter/material.dart';
import 'package:recipe/core/common/widgets/app_list_fallback_widget.dart';

class AppListView extends StatelessWidget {
  const AppListView({
    required this.itemCount,
    required this.itemBuilder,
    super.key,
    this.separatorBuilder,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.scrollDirection = Axis.vertical,
    this.isLoading = false,
    this.loadingItemCount = 5,
    this.skeletonBuilder,
    this.emptyWidget,
    this.errorWidget,
    this.hasError = false,
    this.itemExtent,
    this.scrollController,
    this.onRefresh,
    this.reverse = false,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  final bool isLoading;
  final int loadingItemCount;
  final IndexedWidgetBuilder? skeletonBuilder;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final bool hasError;
  final double? itemExtent;
  final ScrollController? scrollController;
  final Future<void> Function()? onRefresh;
  final bool reverse;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  @override
  Widget build(BuildContext context) {
    if (isLoading && skeletonBuilder != null) {
      return _buildList(loadingItemCount, skeletonBuilder!);
    }
    if (hasError) {
      return errorWidget ?? const DefaultErrorWidget();
    }
    if (!isLoading && itemCount == 0) {
      return emptyWidget ?? const DefaultEmptyWidget();
    }
    final list = _buildList(itemCount, itemBuilder);
    if (onRefresh != null) {
      return RefreshIndicator(onRefresh: onRefresh!, child: list);
    }
    return list;
  }

  Widget _buildList(int count, IndexedWidgetBuilder builder) {
    if (separatorBuilder != null) {
      return ListView.separated(
        controller: scrollController,
        shrinkWrap: shrinkWrap,
        physics:
            physics ??
            (shrinkWrap ? const NeverScrollableScrollPhysics() : null),
        padding: padding ?? const EdgeInsets.all(16),
        scrollDirection: scrollDirection,
        reverse: reverse,
        keyboardDismissBehavior: keyboardDismissBehavior,
        itemCount: count,
        itemBuilder: builder,
        separatorBuilder: separatorBuilder!,
      );
    }
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: shrinkWrap,
      physics:
          physics ?? (shrinkWrap ? const NeverScrollableScrollPhysics() : null),
      padding: padding ?? const EdgeInsets.all(16),
      scrollDirection: scrollDirection,
      reverse: reverse,
      keyboardDismissBehavior: keyboardDismissBehavior,
      itemExtent: itemExtent,
      itemCount: count,
      itemBuilder: builder,
    );
  }
}
