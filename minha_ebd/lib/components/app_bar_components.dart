import 'package:flutter/material.dart';
import 'package:minha_ebd/pages/new_student.dart';
import 'package:minha_ebd/themes/app_color_theme.dart';

class AppBarComponent extends StatelessWidget {
  final String title;
  const AppBarComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      backgroundColor: AppColorTheme.primaryColor,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewStudent(),
              ),
            );
          },
        )
      ],
    );
  }
}
