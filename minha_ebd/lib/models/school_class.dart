import 'package:minha_ebd/models/church_model.dart';
import 'package:minha_ebd/models/student_model.dart';
import 'package:objectbox/objectbox.dart';
import 'package:signals/signals.dart';

@Entity()
class SchoolClassModel {
  int id = 0;
  String? name = "";
  String? classification = "";

  @Backlink('SchoolClassModel')
  final Signal<List<StudentModel>> enrolledStudents = signal([]);

  final church = ToOne<ChurchModel>();

  SchoolClassModel({this.name, this.classification});
}
