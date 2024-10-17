import 'package:flutter/material.dart';
import 'package:minha_ebd/themes/app_color_theme.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: AppColorTheme.tertiaryColor),
            child: ListTile(
              title:
                  Text('Vila Tatetuba', style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.church, color: Colors.white),
            ),
          ),
          ListTile(
            title: const Text('Home', style: TextStyle(color: Colors.black)),
            leading: const Icon(Icons.home, color: Colors.black),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            },
          ),
          ListTile(
            title: const Text('Alunos', style: TextStyle(color: Colors.black)),
            leading: const Icon(Icons.people, color: Colors.black),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/student', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
