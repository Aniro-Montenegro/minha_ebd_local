import 'package:flutter/material.dart';
import 'package:minha_ebd/components/app_bar_components.dart';
import 'package:minha_ebd/components/drawer_component.dart';
import 'package:minha_ebd/models/church_model.dart';
import 'package:minha_ebd/pages/new_church.dart';
import 'package:minha_ebd/services/church_service.dart';

class ChurchPage extends StatefulWidget {
  const ChurchPage({super.key});

  @override
  State<ChurchPage> createState() => _ChurchPageState();
}

class _ChurchPageState extends State<ChurchPage> {
  ChurchService churchService = ChurchService();

  ChurchModel church = ChurchModel(
      id: 0, churchName: '', shepherdName: '', schoolDirectorName: '');

  @override
  void initState() {
    super.initState();
    getChurch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerComponent(),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarComponent(title: 'Igreja')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewChurch(church: church);
          })).then((value) {
            getChurch();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 18),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Igreja: ${church.churchName}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Dirigente: ${church.shepherdName}'),
                        Text('Superintendente: ${church.schoolDirectorName}'),
                        Text('Quantidade de alunos: ${church.students.length}'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getChurch() async {
    church = await churchService.getChurche();
    setState(() {});
  }
}
