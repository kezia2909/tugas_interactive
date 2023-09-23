import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/notes_model.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  TextEditingController _controllerNilai = TextEditingController();

  List<NotesModel> listOfNotes = [];

  void addNotes(String nilai) {
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
        setState(() {
          listOfNotes.add(NotesModel(nilai: tempNilai!, grade: grade));
          print("List : ${listOfNotes}");
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
