# infinite_scroll_list

[![pub package](https://img.shields.io/pub/v/infinite_scroll_list.svg)](https://pub.dev/packages/infinite_scroll_list)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter package that provides an easy-to-use infinite scrolling list widget with built-in loading indicators and pagination support. Perfect for implementing endless scrolling lists, feed interfaces, or any scenario where you need to load data incrementally as the user scrolls.

<p align="center">
  <img src="assets/demo_screenshot.svg" alt="Infinite Scroll List Demo" width="300">
</p>

## Features

- 🔄 Automatic pagination handling
- 📱 Smooth infinite scrolling experience
- 🎯 Generic type support for any data type
- 🔌 Easy-to-use delegate pattern
- 🎨 Customizable item builders
- ⚡ Built-in loading indicators
- 📦 Minimal setup required

## Getting Started

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  infinite_scroll_list: ^0.0.1
```

Then run:

```bash
$ flutter pub get
```

### Basic Usage

```dart
import 'package:infinite_scroll_list/infinite_scroll_list.dart';

InfiniteListView<String>(
  delegate: ItemBuilderDelegate<String>(
    pageRequest: (pageKey) async {
      // Fetch your data here
      // pageKey starts from 0 and increments automatically
      final response = await yourApiCall(pageKey);
      return response.items; // Return List<String>
    },
    itemBuilder: (context, item, index) => ListTile(
      title: Text(item),
    ),
    pageSize: 20, // Optional: defaults to 20
  ),
)
```

## API Reference

### InfiniteListView

The main widget that implements infinite scrolling functionality.

```dart
InfiniteListView<T>(
  delegate: ItemBuilderDelegate<T>(...),
  key: Key('your-key'), // Optional
)
```

### ItemBuilderDelegate

Handles the item building and data fetching logic.

#### Constructor

```dart
ItemBuilderDelegate<T>({
  required ItemBuilder<T> itemBuilder,
  required Future<List<T>> Function(int pageKey) pageRequest,
  int pageSize = 20,
})
```

#### Parameters

- `itemBuilder`: `(BuildContext context, T item, int index) => Widget`
  - Builds the widget for each item in the list
  - Called for each item when it needs to be displayed

- `pageRequest`: `(int pageKey) => Future<List<T>>`
  - Async function that fetches data for the given page
  - `pageKey` starts from 0 and increments automatically
  - Should return a List of items of type T

- `pageSize`: `int`
  - Number of items to load per page
  - Defaults to 20

### LoadingIndicator

A customizable loading indicator widget shown during data fetching.

```dart
const LoadingIndicator()
```

## Advanced Example

Here's a more complete example showing how to implement an infinite scrolling list with custom items:

```dart
class Post {
  final String title;
  final String description;
  
  Post({required this.title, required this.description});
}

InfiniteListView<Post>(
  delegate: ItemBuilderDelegate<Post>(
    pageSize: 10,
    pageRequest: (pageKey) async {
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));
      return List.generate(
        10,
        (index) => Post(
          title: 'Post ${pageKey * 10 + index + 1}',
          description: 'Description for post ${pageKey * 10 + index + 1}',
        ),
      );
    },
    itemBuilder: (context, post, index) => Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.description),
      ),
    ),
  ),
)
```

## Contributing

Contributions are welcome! If you find a bug or want to add a feature, please feel free to:

1. Open an issue
2. Create a pull request
3. Submit feedback or suggestions

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
