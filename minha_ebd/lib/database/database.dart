import 'package:minha_ebd/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class OpenDataBase {
  late final Store store;

  OpenDataBase._create(this.store);

  static Future<OpenDataBase> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "minha_ebd"));
    return OpenDataBase._create(store);
  }
}
