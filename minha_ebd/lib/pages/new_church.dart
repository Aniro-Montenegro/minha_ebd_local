// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:minha_ebd/components/app_bar_components.dart';
import 'package:minha_ebd/models/church_model.dart';
import 'package:minha_ebd/services/church_service.dart';
import 'package:minha_ebd/utils/alert_utils/alerts.dart';

class NewChurch extends StatefulWidget {
  final ChurchModel? church;
  const NewChurch({
    super.key,
    this.church,
  });

  @override
  State<NewChurch> createState() => _NewChurchState();
}

class _NewChurchState extends State<NewChurch> {
  TextEditingController churchNameController = TextEditingController();
  TextEditingController shepherdNameController = TextEditingController();
  TextEditingController schoolDirectorNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ChurchService churchService = ChurchService();

  @override
  void initState() {
    if (widget.church!.id > 0) {
      churchNameController.text = widget.church!.churchName;
      shepherdNameController.text = widget.church!.shepherdName;
      schoolDirectorNameController.text = widget.church!.schoolDirectorName;
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarComponent(title: 'Nova Igreja')),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                    controller: churchNameController,
                    decoration:
                        const InputDecoration(labelText: 'Nome da Igreja'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                    controller: shepherdNameController,
                    decoration:
                        const InputDecoration(labelText: 'Nome do Pastor'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Campo obrigatório' : null,
                    controller: schoolDirectorNameController,
                    decoration: const InputDecoration(
                        labelText: 'Nome do Superintendente'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.church!.churchName = churchNameController.text;
                      widget.church!.shepherdName = shepherdNameController.text;
                      widget.church!.schoolDirectorName =
                          schoolDirectorNameController.text;

                      churchService.saveChurch(widget.church!).then((value) {
                        if (value) {
                          Alerts.showAlertDialog(context, 'Nova Igreja',
                              'Igreja salva com sucesso');
                        }
                      });
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
