import 'package:flutter/material.dart';
import 'package:mini_project/ui/meals_detail_page.dart';
import 'package:mini_project/ui/meals_list_page.dart';
import 'package:mini_project/ui/web_view.dart';
import 'package:mini_project/data/detail_arguments.dart';
import 'package:mini_project/data/webview_arguments.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Project',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MealsListPage(),
        '/web_view': (context) => WebView(
            ModalRoute.of(context)?.settings.arguments as ArgumentsWebView),
        '/meal_detail': (context) => MealsDetailPage(
              ModalRoute.of(context)?.settings.arguments as ArgumentsDetail,
            ),
      },
    );
  }
}
