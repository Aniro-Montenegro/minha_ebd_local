// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:minha_ebd/components/app_bar_components.dart';
import 'package:minha_ebd/models/church_model.dart';
import 'package:minha_ebd/models/school_class.dart';
import 'package:minha_ebd/services/church_service.dart';
import 'package:minha_ebd/services/school_class_page_service.dart';
import 'package:minha_ebd/themes/app_color_theme.dart';
import 'package:minha_ebd/utils/alert_utils/alerts.dart';

class NewSchoolClassPage extends StatefulWidget {
  final SchoolClassModel? schoolClass;
  const NewSchoolClassPage({super.key, this.schoolClass});

  @override
  State<NewSchoolClassPage> createState() => _NewSchoolClassPageState();
}

class _NewSchoolClassPageState extends State<NewSchoolClassPage> {
  ChurchService chruchService = ChurchService();
  SchoolClassService schoolServices = SchoolClassService();
  ChurchModel church = ChurchModel(
      id: 0, churchName: "", shepherdName: "", schoolDirectorName: "");

  SchoolClassModel schoolClass = SchoolClassModel();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController classificationController = TextEditingController();
  var dateFormatter = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  var phoneFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  String selectedFaixaEtaria = '';

  List<String> faixasEtarias = [
    'Crianças (3-5 anos)',
    'Crianças (6-8 anos)',
    'Pré-adolescentes (9-11 anos)',
    'Adolescentes (12-14 anos)',
    'Juvenis (15-17 anos)',
    'Jovens (18-25 anos)',
    'Adultos (25+ anos)',
  ];
  @override
  void initState() {
    schoolClass.name = "";
    schoolClass.classification = "";
    chruchService.getChurche().then((value) {
      setState(() {
        church = value;
        if (church.id == 0) {
          Alerts.showAlertDialog(context, 'Nova Igreja',
              'Você precisa cadastrar uma igreja antes de cadastrar uma classe!');
        }
      });
    });
    super.initState();

    if (widget.schoolClass != null) {
      schoolClass = widget.schoolClass!;
      nameController.text = schoolClass.name!;
      classificationController.text = schoolClass.classification!;
    } else {
      nameController.text = '';
      classificationController.text = '';
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
                      schoolClass.name = value;
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                ),
                TextField(
                  controller: classificationController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Selecione a Faixa Etária',
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                  onTap: _showFaixaEtariaSelection,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: AppColorTheme.primaryColorProperty,
                        fixedSize:
                            WidgetStateProperty.all(const Size(200, 50))),
                    onPressed: () {
                      if (widget.schoolClass == null &&
                          formKey.currentState!.validate()) {
                        schoolClass.classification = selectedFaixaEtaria;

                        schoolClass.name = nameController.text;
                        schoolServices
                            .saveSchoolClass(schoolClass, church)
                            .then((value) {
                          if (value) {
                            Alerts.showAlertDialog(context, 'Nova Classe',
                                'Classe salva com sucesso!');
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

  void _showFaixaEtariaSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: faixasEtarias.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: const Icon(Icons.arrow_right),
              title: Text(faixasEtarias[index]),
              onTap: () {
                setState(() {
                  selectedFaixaEtaria = faixasEtarias[index];
                  classificationController.text = selectedFaixaEtaria;
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
