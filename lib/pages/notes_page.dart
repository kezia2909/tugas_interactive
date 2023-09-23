import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/sql_helper.dart';
import 'package:flutter_application_1/models/notes_model.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  TextEditingController _controllerNilai = TextEditingController();

  List<NotesModel> listOfNotes = [];
  final sqlHelper = SQLHelper();

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await sqlHelper.getNotes();
    setState(() {
      this.listOfNotes = notes;
    });
  }

  void addNotes(String nilai) async {
    String grade = "E";
    double? tempNilai;
    try {
      tempNilai = double.tryParse(nilai);
      if (tempNilai == null) {
        print("error : $nilai");
      } else {
        print("oke : $tempNilai");
        print("temp : $tempNilai");
        if (tempNilai >= 85.5) {
          grade = "A";
        } else if (tempNilai >= 75.5) {
          grade = "B+";
        } else if (tempNilai >= 68.5) {
          grade = "B";
        } else if (tempNilai >= 60.5) {
          grade = "C+";
        } else if (tempNilai >= 55.5) {
          grade = "C";
        } else if (tempNilai >= 40.5) {
          grade = "D";
        }
        // setState(() {
        //   listOfNotes.add(NotesModel(nilai: tempNilai!, grade: grade));
        //   print("List : ${listOfNotes}");
        // });
        final newNote = NotesModel(nilai: tempNilai, grade: grade);
        print("NEW NOTE : $newNote");
        await sqlHelper.insertNotes(newNote);
        setState(() {
          _loadNotes();
        });
      }
    } catch (e) {
      print("error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controllerNilai,
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          child: Text("Submit"),
          onPressed: () {
            addNotes(_controllerNilai.text.toString());
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: listOfNotes.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nilai : ${listOfNotes[index].nilai}",
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    "Nilai : ${listOfNotes[index].grade}",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
