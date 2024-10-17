import 'package:minha_ebd/models/school_class.dart';
import 'package:minha_ebd/models/student_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ChurchModel {
  int id = 0;
  String churchName;
  String shepherdName;
  String schoolDirectorName;

  ChurchModel(
      {required this.id,
      required this.churchName,
      required this.shepherdName,
      required this.schoolDirectorName});
  @Backlink('church')
  final students = ToMany<StudentModel>();
  @Backlink('church')
  final schoolClasses = ToMany<SchoolClassModel>();
}
