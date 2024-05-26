import 'dart:async';
import 'package:flutter/material.dart';

class InfiniteListView extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final NullableIndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final Future<void> Function() onLoadMore;
  final bool canLoadMore;
  final Widget? empty;

  const InfiniteListView({
    super.key,
    this.padding,
    required this.itemCount,
    required this.itemBuilder,
    required this.onLoadMore,
    required this.canLoadMore,
    this.empty,
  });

  @override
  State<InfiniteListView> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  bool _isLoadingMore = false;
  final _scrollController = ScrollController();

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_isLoadingMore || !widget.canLoadMore) return;

      setState(() => _isLoadingMore = true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
      await widget.onLoadMore();
      setState(() => _isLoadingMore = false);
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0 && widget.empty != null) {
      return widget.empty!;
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      padding: widget.padding,
      itemCount: widget.itemCount + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < widget.itemCount) {
          return widget.itemBuilder(context, index);
        }
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }
}
