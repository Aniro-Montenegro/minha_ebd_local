import 'package:minha_ebd/main.dart';
import 'package:minha_ebd/models/church_model.dart';
import 'package:minha_ebd/models/school_class.dart';
import 'package:objectbox/objectbox.dart';

class SchoolClassService {
  final box = database.store.box<SchoolClassModel>();

  Future<List<SchoolClassModel>> getSchoolClass() async {
    final classes = box.getAll();
    return classes;
  }

  Future<bool> updateSchoolClass(SchoolClassModel schoolClasse) async {
    int id = 0;
    if (schoolClasse.id == 0) {
      id = box.put(schoolClasse);
    } else {
      id = box.put(schoolClasse, mode: PutMode.update);
    }

    return id > 0;
  }

  Future<bool> deleteSchoolClass(SchoolClassModel schoolClasse) async {
    final status = box.remove(schoolClasse.id);
    return status;
  }

  Future<bool> saveSchoolClass(
      SchoolClassModel schoolClasse, ChurchModel church) async {
    schoolClasse.church.target = church;
    int id = box.put(schoolClasse);

    return id > 0;
  }
}
