// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:minha_ebd/components/app_bar_components.dart';
import 'package:minha_ebd/models/church_model.dart';
import 'package:minha_ebd/models/student_model.dart';
import 'package:minha_ebd/services/church_service.dart';
import 'package:minha_ebd/services/student_services.dart';
import 'package:minha_ebd/themes/app_color_theme.dart';
import 'package:minha_ebd/utils/alert_utils/alerts.dart';

class NewStudent extends StatefulWidget {
  final StudentModel? student;
  const NewStudent({super.key, this.student});

  @override
  State<NewStudent> createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  ChurchService chruchService = ChurchService();
  StudentServices studentServices = StudentServices();
  ChurchModel church = ChurchModel(
      id: 0, churchName: "", shepherdName: "", schoolDirectorName: "");

  StudentModel student =
      StudentModel(name: "", birthDate: DateTime.now(), phone: "");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  var dateFormatter = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  var phoneFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    chruchService.getChurche().then((value) {
      setState(() {
        church = value;
        if (church.id == 0) {
          Alerts.showAlertDialog(context, 'Nova Igreja',
              'Você precisa cadastrar uma igreja antes de cadastrar um aluno!');
        }
      });
    });
    super.initState();

    if (widget.student != null) {
      student = widget.student!;
      nameController.text = student.name;
      phoneController.text = student.phone;
      birthDateController.text = student.birthDate.toString();
    } else {
      nameController.text = '';
      phoneController.text = '';
      birthDateController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarComponent(title: 'Novo Aluno')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 18),
        child: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    onChanged: (value) {
                      student.name = value;
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: phoneController,
                    inputFormatters: [phoneFormatter],
                    decoration: const InputDecoration(labelText: 'Telefone'),
                    onChanged: (value) {
                      student.phone = value;
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: birthDateController,
                    inputFormatters: [dateFormatter],
                    decoration:
                        const InputDecoration(labelText: 'Data de Nascimento'),
                    onChanged: (value) {
                      if (value.length == 10) {
                        try {
                          final parts = value.split('/');
                          final day = int.parse(parts[0]);
                          final month = int.parse(parts[1]);
                          final year = int.parse(parts[2]);
                          student.birthDate = DateTime(year, month, day);
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      }
                    },
                    validator: (value) {
                      if (value!.length != 10) {
                        return 'Data inválida';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: AppColorTheme.primaryColorProperty,
                        fixedSize:
                            WidgetStateProperty.all(const Size(200, 50))),
                    onPressed: () {
                      if (widget.student == null &&
                          formKey.currentState!.validate()) {
                        studentServices
                            .saveStudent(student, church)
                            .then((value) {
                          if (value) {
                            Alerts.showAlertDialog(context, 'Novo Aluno',
                                'Aluno salvo com sucesso!');
                          }
                        });
                      }
                    },
                    child: const Text('Salvar',
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ])),
        ),
      ),
    );
  }
}
