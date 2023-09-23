import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    _controllerNilai.addListener(
      () {
        if (_controllerNilai.text == ".") {
          setState(() {
            _controllerNilai.text = "0.";
          });
        }
        inputValidation();
      },
    );
  }

  @override
  void dispose() {
    _controllerNilai.dispose();
    super.dispose();
  }

  void inputValidation() {
    String input = _controllerNilai.text.trim();
    print("input : $input");
    if (input.isNotEmpty) {
      final tempNilai = double.tryParse(input);
      if (tempNilai != null) {
        print("oke : $tempNilai");
        print("temp : $tempNilai");
        if (tempNilai > 100) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Input max 100.0'),
            ),
          );
        }
      } else {
        print("error : $input");
      }
    }
    setState(() {});
  }

  Future<void> _loadNotes() async {
    final notes = await sqlHelper.getNotes();
    setState(() {
      this.listOfNotes = notes;
    });
  }

  String convertGrade(double nilai) {
    String grade = "E";
    if (nilai >= 85.5) {
      grade = "A";
    } else if (nilai >= 75.5) {
      grade = "B+";
    } else if (nilai >= 68.5) {
      grade = "B";
    } else if (nilai >= 60.5) {
      grade = "C+";
    } else if (nilai >= 55.5) {
      grade = "C";
    } else if (nilai >= 40.5) {
      grade = "D";
    }
    return grade;
  }

  void addNotes(String nilai) async {
    double? tempNilai;
    try {
      tempNilai = double.tryParse(nilai);
      if (tempNilai == null) {
        print("error : $nilai");
      } else {
        print("oke : $tempNilai");
        print("temp : $tempNilai");

        final newNote =
            NotesModel(nilai: tempNilai, grade: convertGrade(tempNilai));
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
    return Container(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        children: [
          TextField(
            controller: _controllerNilai,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
            ],
            decoration: InputDecoration(
              hintText: "ex : 95.6, 70, etc",
              label: Text("nilai (0.0-100.0)"),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.solid)),
            ),
          ),
          ElevatedButton(
            child: Text("Submit"),
            onPressed: () {
              addNotes(_controllerNilai.text.toString());
              _controllerNilai.clear();
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
      ),
    );
  }
}
