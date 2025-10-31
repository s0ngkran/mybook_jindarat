import 'package:get/get.dart';
import '../../models/book.dart';
import '../../services/app_service.dart';

class BookListController extends GetxController {
  final AppService appService = Get.find<AppService>();
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadBooks();
  }

  Future<void> loadBooks() async {
    await appService.loadBooks();
  }

  List<Book> get filteredBooks {
    if (searchQuery.value.isEmpty) {
      return appService.books;
    }
    final query = searchQuery.value.toLowerCase();
    return appService.books.where((book) {
      return book.title.toLowerCase().contains(query) ||
          book.price.toString().contains(query) ||
          book.reviewStar.toString().contains(query);
    }).toList();
  }
}
