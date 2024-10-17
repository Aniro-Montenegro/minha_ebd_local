import 'package:minha_ebd/models/student_model.dart';
import 'package:signals/signals.dart';

class BibleStudy {
  late String id;
  Signal<DateTime> date = signal(DateTime.now());
  Signal<String> title = signal("");
  Signal<List<StudentModel>> students = signal([]);
}
