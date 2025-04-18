import 'package:flutter/material.dart';
import 'item_builder_delegate.dart';
import 'loading_indicator.dart';

class InfiniteListView<T> extends StatefulWidget {
  final ItemBuilderDelegate<T> delegate;

  const InfiniteListView({super.key, required this.delegate});

  @override
  State<InfiniteListView<T>> createState() => _InfiniteListViewState<T>();
}

class _InfiniteListViewState<T> extends State<InfiniteListView<T>> {
  final ScrollController _scrollController = ScrollController();
  final List<T> _items = [];
  int _pageKey = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !_isLoading && _hasMore) {
        _loadMore();
      }
    });
  }

  Future<void> _loadMore() async {
    setState(() => _isLoading = true);
    final newItems = await widget.delegate.pageRequest(_pageKey);
    setState(() {
      _items.addAll(newItems);
      _isLoading = false;
      _hasMore = newItems.length == widget.delegate.pageSize;
      if (_hasMore) _pageKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: _items.length + (_isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < _items.length) {
          return widget.delegate.itemBuilder(context, _items[index], index);
        } else {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: LoadingIndicator()),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
