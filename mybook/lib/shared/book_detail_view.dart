import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/book.dart';
import '../services/app_service.dart';

class BookDetailView extends StatelessWidget {
  final Book book;

  const BookDetailView({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final appService = Get.find<AppService>();

    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: const Text('รายละเอียดหนังสือ'),
        backgroundColor: Colors.purple.shade300,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    book.imageUrl,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        width: 180,
                        color: Colors.purple.shade200,
                        child: Icon(Icons.book, color: Colors.purple.shade400, size: 80),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        '${book.reviewStar} ดาว',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '฿${book.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(() {
                      final currentBook = appService.books.firstWhere(
                        (b) => b.id == book.id,
                        orElse: () => book,
                      );
                      return ElevatedButton.icon(
                        onPressed: () => appService.toggleFavorite(currentBook),
                        icon: Icon(
                          currentBook.isFav ? Icons.favorite : Icons.favorite_border,
                        ),
                        label: Text(
                          currentBook.isFav ? 'ลบออกจากรายการโปรด' : 'เพิ่มในรายการโปรด',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: currentBook.isFav ? Colors.pink : Colors.purple.shade300,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
