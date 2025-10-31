import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/confirm_dialog.dart';
import '../../shared/note_edit_dialog.dart';
import 'book_notes_controller.dart';

class BookNotesView extends GetView<BookNotesController> {
  const BookNotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: const Text('บันทึกหนังสือ'),
        backgroundColor: Colors.purple.shade300,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.loadNotes,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                final favoriteBooks = controller.appService.favoriteBooks;
                if (favoriteBooks.isEmpty) {
                  Get.snackbar('ไม่สามารถเพิ่มบันทึกได้', 'กรุณาเพิ่มหนังสือโปรดก่อน');
                  return;
                }
                showDialog(
                  context: context,
                  builder: (context) => NoteEditDialog(
                    favoriteBooks: favoriteBooks,
                    onSave: (bookId, note, tags) async {
                      await controller.createNote(
                        bookId: bookId,
                        note: note,
                        tags: tags,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('เพิ่มบันทึก'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade300,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.appService.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final notes = controller.appService.notes;

              if (notes.isEmpty) {
                return const Center(
                  child: Text(
                    'ยังไม่มีบันทึก',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.loadNotes,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.note,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (note.tag.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 4,
                                children: note.tag.map((tag) {
                                  return Chip(
                                    label: Text(tag),
                                    backgroundColor: Colors.purple.shade100,
                                    labelStyle: TextStyle(
                                      color: Colors.purple.shade700,
                                      fontSize: 12,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    final favoriteBooks = controller.appService.favoriteBooks;
                                    showDialog(
                                      context: context,
                                      builder: (context) => NoteEditDialog(
                                        note: note,
                                        favoriteBooks: favoriteBooks,
                                        onSave: (bookId, noteText, tags) async {
                                          await controller.updateNote(
                                            id: note.id!,
                                            bookId: bookId,
                                            note: noteText,
                                            tags: tags,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: Colors.blue,
                                ),
                                IconButton(
                                  onPressed: () {
                                    ConfirmDialog.show(
                                      context,
                                      title: 'ยืนยันการลบ',
                                      message: 'คุณต้องการลบบันทึกนี้หรือไม่?',
                                      onConfirm: () async {
                                        await controller.deleteNote(note.id!);
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
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
