import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/book_list/book_list_controller.dart';
import 'screens/book_list/book_list_view.dart';
import 'screens/my_books/my_books_controller.dart';
import 'screens/my_books/my_books_view.dart';
import 'screens/book_notes/book_notes_controller.dart';
import 'screens/book_notes/book_notes_view.dart';
import 'services/app_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() async => AppService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyBook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple.shade300,
          primary: Colors.purple.shade300,
        ),
        useMaterial3: true,
      ),
      home: const MainView(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => BookListController());
        Get.lazyPut(() => MyBooksController());
        Get.lazyPut(() => BookNotesController());
      }),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class MainViewController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}

class _MainViewState extends State<MainView> {
  final MainViewController _controller = Get.put(MainViewController());

  final List<Widget> _pages = [
    const BookListView(),
    const MyBooksView(),
    const BookNotesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: _pages[_controller.currentIndex.value],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _controller.currentIndex.value,
            onTap: (index) {
              _controller.changeTab(index);
            },
            selectedItemColor: Colors.purple.shade700,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'หน้าหลัก',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'โปรด',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_note),
                label: 'บันทึก',
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
