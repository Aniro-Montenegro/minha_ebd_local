import 'package:flutter/material.dart';
import 'package:minha_ebd/components/drawer_component.dart';
import 'package:minha_ebd/models/student_model.dart';
import 'package:minha_ebd/pages/new_student.dart';
import 'package:minha_ebd/services/student_services.dart';
import 'package:minha_ebd/themes/app_color_theme.dart';
import 'package:minha_ebd/utils/alert_utils/alerts.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  StudentServices studentServices = StudentServices();

  List<StudentModel> students = [];

  @override
  void initState() {
    super.initState();

    studentServices.getStudents().then((value) {
      setState(() {
        students = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerComponent(),
      appBar: AppBar(
        title: const Text('Novo Aluno', style: TextStyle(color: Colors.white)),
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
              ).then((value) {
                studentServices.getStudents().then((value) {
                  setState(() {
                    students = value;
                  });
                });
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
            itemCount: students.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(students[index].name),
                subtitle: Text(students[index].phone),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showModalEditStudent(students[index]);
                  },
                ),
              );
            }),
      ),
    );
  }

  void showModalEditStudent(StudentModel student) {
    showModalBottomSheet(
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'Sair',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColorTheme.primaryColor),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    color: AppColorTheme.primaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                TextFormField(
                  initialValue: student.name,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  onChanged: (value) {
                    student.name = value;
                  },
                ),
                TextFormField(
                  initialValue: student.phone,
                  decoration: const InputDecoration(labelText: 'Telefone'),
                  onChanged: (value) {
                    student.phone = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    studentServices.updateStudent(student).then((value) {
                      if (value) {
                        Alerts.showAlertDialog(context, 'Aluno Atualizado',
                            'Aluno atualizado com sucesso');
                        studentServices.getStudents().then((value) {
                          setState(() {
                            students = value;
                          });
                        });
                      }
                    });
                  },
                  child: const Text('Salvar'),
                )
              ],
            ),
          );
        });
  }
}
