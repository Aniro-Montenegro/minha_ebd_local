import 'package:minha_ebd/main.dart';
import 'package:minha_ebd/models/church_model.dart';
import 'package:minha_ebd/objectbox.g.dart';

class ChurchService {
  final box = database.store.box<ChurchModel>();
  Future<ChurchModel> getChurche() async {
    final church = box.getAll();
    // ignore: unnecessary_null_comparison
    if (church.isEmpty) {
      return ChurchModel(
          id: 0, churchName: "", shepherdName: "", schoolDirectorName: "");
    }
    return church.first;
  }

  Future<bool> updateChurch(ChurchModel church) async {
    int id = 0;
    if (church.id == 0) {
      id = box.put(church);
    } else {
      id = box.put(church, mode: PutMode.update);
    }

    return id > 0;
  }

  Future<bool> deleteChurch(ChurchModel church) async {
    final status = box.remove(church.id);
    return status;
  }

  Future<bool> saveChurch(ChurchModel church) async {
    int id = await box.putAsync(church);

    return id > 0;
  }
}
