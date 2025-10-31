import 'package:get/get.dart';
import '../models/book.dart';
import '../models/book_note.dart';
import 'api_service.dart';

class AppService extends GetxService {
  final ApiService _apiService = ApiService();

  final RxList<Book> books = <Book>[].obs;
  final RxList<BookNote> notes = <BookNote>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> loadBooks() async {
    try {
      isLoading.value = true;
      books.value = await _apiService.getBooks();
    } catch (e) {
      Get.snackbar('ข้อผิดพลาด', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite(Book book) async {
    try {
      final updatedBook = await _apiService.updateBook(
        book.id!,
        isFav: !book.isFav,
      );
      final index = books.indexWhere((b) => b.id == book.id);
      if (index != -1) {
        books[index] = updatedBook;
      }
    } catch (e) {
      Get.snackbar('ข้อผิดพลาด', e.toString());
    }
  }

  Future<void> loadNotes() async {
    try {
      isLoading.value = true;
      notes.value = await _apiService.getBookNotes();
    } catch (e) {
      Get.snackbar('ข้อผิดพลาด', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createNote(BookNote note) async {
    try {
      final newNote = await _apiService.createBookNote(note);
      notes.add(newNote);
    } catch (e) {
      Get.snackbar('ข้อผิดพลาด', e.toString());
    }
  }

  Future<void> updateNote(int id, BookNote note) async {
    try {
      final updatedNote = await _apiService.updateBookNote(id, note);
      final index = notes.indexWhere((n) => n.id == id);
      if (index != -1) {
        notes[index] = updatedNote;
      }
    } catch (e) {
      Get.snackbar('ข้อผิดพลาด', e.toString());
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await _apiService.deleteBookNote(id);
      notes.removeWhere((n) => n.id == id);
    } catch (e) {
      Get.snackbar('ข้อผิดพลาด', e.toString());
    }
  }

  List<Book> get favoriteBooks => books.where((b) => b.isFav).toList();
}
