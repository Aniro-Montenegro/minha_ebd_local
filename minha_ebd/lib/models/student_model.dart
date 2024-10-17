import 'package:minha_ebd/models/church_model.dart';
import 'package:minha_ebd/models/school_class.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class StudentModel {
  int id = 0;

  String name;
  @Property(type: PropertyType.date)
  DateTime birthDate;
  String phone;

  final church = ToOne<ChurchModel>();
  final schoolClass = ToOne<SchoolClassModel>();

  StudentModel(
      {required this.name, required this.birthDate, required this.phone});
}
