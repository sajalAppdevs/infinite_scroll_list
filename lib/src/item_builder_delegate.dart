import 'package:flutter/cupertino.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, T item, int index);

class ItemBuilderDelegate<T> {
  final ItemBuilder<T> itemBuilder;
  final Future<List<T>> Function(int pageKey) pageRequest;
  final int pageSize;

  ItemBuilderDelegate({
    required this.itemBuilder,
    required this.pageRequest,
    this.pageSize = 20,
  });
}
