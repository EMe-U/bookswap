import 'package:flutter/material.dart';
import '../widgets/book_card.dart';
import '../widgets/my_app_bar.dart';

class BrowseScreen extends StatelessWidget {
  final List<Map<String, String>> books = [
    {
      'title': 'Data Structures & Algorithms',
      'author': 'Themail V Dermon',
      'condition': 'Like New',
      'timePosted': '3 days ago',
      'imageUrl': 'https://covers.openlibrary.org/b/id/8231856-L.jpg',
    },
    {
      'title': 'Operating Systems',
      'author': 'John Doe',
      'condition': 'Used',
      'timePosted': '2 days ago',
      'imageUrl': 'https://covers.openlibrary.org/b/id/7222246-L.jpg',
    },
    {
      'title': 'Operating Systems',
      'author': 'Jane Smith',
      'condition': 'Good',
      'timePosted': '1 day ago',
      'imageUrl': 'https://covers.openlibrary.org/b/id/7222246-L.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Browse Listings'),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final b = books[index];
          return BookCard(
            title: b['title']!,
            author: b['author']!,
            condition: b['condition']!,
            timePosted: b['timePosted']!,
            imageUrl: b['imageUrl']!,
          );
        },
      ),
    );
  }
}
