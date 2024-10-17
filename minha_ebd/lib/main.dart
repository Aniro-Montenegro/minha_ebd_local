import 'package:flutter/material.dart';
import 'package:minha_ebd/database/database.dart';
import 'package:minha_ebd/pages/church_page.dart';
import 'package:minha_ebd/pages/home.dart';
import 'package:minha_ebd/pages/school_class_page.dart';
import 'package:minha_ebd/pages/student_page.dart';

late OpenDataBase database;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = await OpenDataBase.create();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      initialRoute: '/home',
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const HomePage(),
        '/student': (BuildContext context) => const StudentPage(),
        '/church_page': (BuildContext context) => const ChurchPage(),
        '/school_class_page': (BuildContext context) => const SchoolClassPage(),
      },
    );
  }
}
