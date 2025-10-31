import 'package:get/get.dart';
import '../../models/book.dart';
import '../../services/app_service.dart';

class MyBooksController extends GetxController {
  final AppService appService = Get.find<AppService>();

  List<Book> get favoriteBooks => appService.favoriteBooks;

  Future<void> refresh() async {
    await appService.loadBooks();
  }
}
