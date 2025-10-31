import 'package:get/get.dart';
import '../../models/book_note.dart';
import '../../services/app_service.dart';

class BookNotesController extends GetxController {
  final AppService appService = Get.find<AppService>();

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  Future<void> loadNotes() async {
    await appService.loadNotes();
  }

  Future<void> createNote({
    required int bookId,
    required String note,
    required List<String> tags,
  }) async {
    final newNote = BookNote(
      bookId: bookId,
      note: note,
      tag: tags,
    );
    await appService.createNote(newNote);
  }

  Future<void> updateNote({
    required int id,
    required int bookId,
    required String note,
    required List<String> tags,
  }) async {
    final updatedNote = BookNote(
      id: id,
      bookId: bookId,
      note: note,
      tag: tags,
    );
    await appService.updateNote(id, updatedNote);
  }

  Future<void> deleteNote(int id) async {
    await appService.deleteNote(id);
  }
}
