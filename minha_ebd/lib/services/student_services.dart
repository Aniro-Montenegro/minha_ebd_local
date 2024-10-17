import 'package:minha_ebd/main.dart';
import 'package:minha_ebd/models/church_model.dart';
import 'package:minha_ebd/models/student_model.dart';
import 'package:minha_ebd/objectbox.g.dart';

class StudentServices {
  final box = database.store.box<StudentModel>();

  Future<List<StudentModel>> getStudents() async {
    final students = box.getAll();
    return students;
  }

  Future<bool> updateStudent(StudentModel student) async {
    int id = 0;
    if (student.id == 0) {
      id = box.put(student);
    } else {
      id = box.put(student, mode: PutMode.update);
    }

    return id > 0;
  }

  Future<bool> deleteStudent(StudentModel student) async {
    final status = box.remove(student.id);
    return status;
  }

  Future<bool> saveStudent(StudentModel student, ChurchModel church) async {
    student.church.target = church;
    int id = box.put(student);

    return id > 0;
  }
}
