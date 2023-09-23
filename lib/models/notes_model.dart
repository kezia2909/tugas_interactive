class NotesModel {
  int? id;
  double nilai;
  String grade;

  NotesModel({this.id, required this.nilai, required this.grade});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nilai': nilai,
      'grade': grade,
    };
  }
}
