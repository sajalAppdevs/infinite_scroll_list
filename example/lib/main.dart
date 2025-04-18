import 'package:flutter/material.dart';
import 'package:infinite_scroll_list/infinite_scroll_list.dart';

void main() => runApp(const InfiniteScrollDemoApp());

class InfiniteScrollDemoApp extends StatelessWidget {
  const InfiniteScrollDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite Scroll Demo',
      theme: ThemeData.dark(useMaterial3: true),
      home: const DemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  Future<List<String>> fetchItems(int pageKey) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return List.generate(15, (index) => 'Item ${(pageKey * 15) + index + 1}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📜 Infinite Scroll List')),
      body: InfiniteListView<String>(
        delegate: ItemBuilderDelegate<String>(
          pageRequest: fetchItems,
          itemBuilder: (context, item, index) => Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: CircleAvatar(child: Text(item.split(' ').last)),
              title: Text(item, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Dynamically loaded with pagination'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ),
          ),
        ),
      ),
    );
  }
}
