import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/book_card.dart';
import '../../shared/book_detail_view.dart';
import 'my_books_controller.dart';

class MyBooksView extends GetView<MyBooksController> {
  const MyBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: const Text('หนังสือโปรด'),
        backgroundColor: Colors.pink,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refresh,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.appService.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final favoriteBooks = controller.favoriteBooks;

        if (favoriteBooks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 80,
                  color: Colors.pink.shade200,
                ),
                const SizedBox(height: 16),
                const Text(
                  'ยังไม่มีหนังสือโปรด',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refresh,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favoriteBooks.length,
            itemBuilder: (context, index) {
              final book = favoriteBooks[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: BookCard(
                  book: book,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BookDetailView(book: book),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
