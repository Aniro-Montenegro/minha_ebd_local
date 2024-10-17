import 'package:flutter/material.dart';
import 'package:minha_ebd/components/app_bar_components.dart';
import 'package:minha_ebd/components/drawer_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerComponent(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarComponent(title: 'Home'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: <Widget>[
          Card(
            child: Center(
              child: ListTile(
                title: const Text('Igreja'),
                leading: const Icon(Icons.church),
                onTap: () {
                  Navigator.pushNamed(context, '/church_page');
                },
              ),
            ),
          ),
          Card(
            child: Center(
              child: ListTile(
                title: const Text('Estudos Bíblicos'),
                leading: const Icon(Icons.book),
                onTap: () {
                  Navigator.pushNamed(context, '/bible_study');
                },
              ),
            ),
          ),
          Card(
            child: Center(
              child: ListTile(
                title: const Text('Alunos'),
                leading: const Icon(Icons.book),
                onTap: () {
                  Navigator.pushNamed(context, '/student');
                },
              ),
            ),
          ),
          Card(
            child: Center(
              child: ListTile(
                title: const Text('Classes'),
                leading: const Icon(Icons.book),
                onTap: () {
                  Navigator.pushNamed(context, '/school_class_page');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
