import 'package:flutter/material.dart';
import 'package:minha_ebd/components/drawer_component.dart';
import 'package:minha_ebd/models/school_class.dart';
import 'package:minha_ebd/pages/new_school_class.dart';
import 'package:minha_ebd/services/school_class_page_service.dart';
import 'package:minha_ebd/themes/app_color_theme.dart';
import 'package:signals/signals_flutter.dart';

class SchoolClassPage extends StatefulWidget {
  const SchoolClassPage({super.key});

  @override
  State<SchoolClassPage> createState() => _SchoolClassPageState();
}

class _SchoolClassPageState extends State<SchoolClassPage> {
  Signal<List<SchoolClassModel>> classes = signal([]);
  SchoolClassService schoolClassService = SchoolClassService();
  @override
  void initState() {
    schoolClassService.getSchoolClass().then((value) {
      classes.value = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerComponent(),
        appBar: AppBar(
          title: const Text('Classes', style: TextStyle(color: Colors.white)),
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
                    builder: (context) => const NewSchoolClassPage(),
                  ),
                ).then((value) {
                  schoolClassService.getSchoolClass().then((value) {
                    classes.value = value;
                  });
                });
              },
            )
          ],
        ),
        body: SingleChildScrollView(child: Watch((context) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: classes.value.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Turma ${classes.value[index].name}'),
                subtitle:
                    Text('Descrição: ${classes.value[index].classification}'),
              );
            },
          );
        })));
  }
}
