import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_list/infinite_scroll_list.dart';

void main() {
  testWidgets('InfiniteListView loads initial items', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: InfiniteListView<String>(
        delegate: ItemBuilderDelegate<String>(
          pageRequest: (pageKey) async => ['Item 1', 'Item 2'],
          itemBuilder: (context, item, index) => Text(item),
        ),
      ),
    ));

    await tester.pump(const Duration(seconds: 2)); // simulate async load

    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
  });
}
