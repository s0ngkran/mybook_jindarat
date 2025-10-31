import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/book_card.dart';
import '../../shared/book_detail_view.dart';
import 'book_list_controller.dart';

class BookListView extends GetView<BookListController> {
  const BookListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: const Text('รายการหนังสือ'),
        backgroundColor: Colors.purple.shade300,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.loadBooks,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: InputDecoration(
                hintText: 'ค้นหาหนังสือ...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.appService.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final books = controller.filteredBooks;

              if (books.isEmpty) {
                return const Center(
                  child: Text(
                    'ไม่พบหนังสือ',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.loadBooks,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
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
          ),
        ],
      ),
    );
  }
}
