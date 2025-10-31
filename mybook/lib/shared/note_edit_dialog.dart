import 'package:flutter/material.dart';
import '../models/book_note.dart';
import '../models/book.dart';

class NoteEditDialog extends StatefulWidget {
  final BookNote? note;
  final List<Book> books;
  final Function(int bookId, String note, List<String> tags) onSave;

  const NoteEditDialog({
    super.key,
    this.note,
    required this.books,
    required this.onSave,
  });

  @override
  State<NoteEditDialog> createState() => _NoteEditDialogState();
}

class _NoteEditDialogState extends State<NoteEditDialog> {
  late TextEditingController _noteController;
  late TextEditingController _tagController;
  int? _selectedBookId;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.note?.note ?? '');
    _tagController = TextEditingController(
      text: widget.note?.tag.join(', ') ?? '',
    );
    _selectedBookId = widget.note?.bookId;
  }

  @override
  void dispose() {
    _noteController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.note == null ? 'เพิ่มบันทึก' : 'แก้ไขบันทึก',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<int>(
              value: _selectedBookId,
              decoration: InputDecoration(
                labelText: 'เลือกหนังสือ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              isExpanded: true,
              items: widget.books.map((book) {
                return DropdownMenuItem<int>(
                  value: book.id,
                  child: Text(
                    book.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBookId = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'บันทึก',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tagController,
              decoration: InputDecoration(
                labelText: 'แท็ก (คั่นด้วยเครื่องหมายจุลภาค)',
                hintText: 'เช่น: romance, action, favorite',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('ยกเลิก'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_noteController.text.isEmpty || _selectedBookId == null) {
                      return;
                    }
                    final tags = _tagController.text
                        .split(',')
                        .map((t) => t.trim())
                        .where((t) => t.isNotEmpty)
                        .toList();
                    Navigator.of(context).pop();
                    widget.onSave(_selectedBookId!, _noteController.text, tags);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade300,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('บันทึก'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> show(
    BuildContext context, {
    BookNote? note,
    required List<Book> books,
    required Function(int bookId, String note, List<String> tags) onSave,
  }) {
    return showDialog(
      context: context,
      builder: (context) => NoteEditDialog(
        note: note,
        books: books,
        onSave: onSave,
      ),
    );
  }
}
