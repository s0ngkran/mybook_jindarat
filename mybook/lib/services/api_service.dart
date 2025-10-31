import 'package:dio/dio.dart';
import '../models/book.dart';
import '../models/book_note.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';
  final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  Future<List<Book>> getBooks() async {
    try {
      final response = await _dio.get('/books');
      return (response.data as List).map((json) => Book.fromJson(json)).toList();
    } catch (e) {
      throw Exception('ไม่สามารถโหลดรายการหนังสือได้: $e');
    }
  }

  Future<Book> createBook(Book book) async {
    try {
      final response = await _dio.post('/books', data: book.toJson());
      return Book.fromJson(response.data);
    } catch (e) {
      throw Exception('ไม่สามารถสร้างหนังสือได้: $e');
    }
  }

  Future<Book> updateBook(int id, {required bool isFav}) async {
    try {
      final response = await _dio.put('/books/$id', data: {'isFav': isFav});
      return Book.fromJson(response.data);
    } catch (e) {
      throw Exception('ไม่สามารถอัพเดทหนังสือได้: $e');
    }
  }

  Future<List<BookNote>> getBookNotes() async {
    try {
      final response = await _dio.get('/book-notes');
      return (response.data as List).map((json) => BookNote.fromJson(json)).toList();
    } catch (e) {
      throw Exception('ไม่สามารถโหลดบันทึกได้: $e');
    }
  }

  Future<BookNote> createBookNote(BookNote note) async {
    try {
      final response = await _dio.post('/book-notes', data: note.toJson());
      return BookNote.fromJson(response.data);
    } catch (e) {
      throw Exception('ไม่สามารถสร้างบันทึกได้: $e');
    }
  }

  Future<BookNote> updateBookNote(int id, BookNote note) async {
    try {
      final response = await _dio.put('/book-notes/$id', data: note.toJson());
      return BookNote.fromJson(response.data);
    } catch (e) {
      throw Exception('ไม่สามารถแก้ไขบันทึกได้: $e');
    }
  }

  Future<void> deleteBookNote(int id) async {
    try {
      await _dio.delete('/book-notes/$id');
    } catch (e) {
      throw Exception('ไม่สามารถลบบันทึกได้: $e');
    }
  }
}
