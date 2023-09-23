import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/helper/sql_helper.dart';
import 'package:flutter_application_1/models/notes_model.dart';
import 'package:flutter_application_1/utils/color_utils.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  TextEditingController _controllerNilai = TextEditingController();

  List<NotesModel> listOfNotes = [];
  final sqlHelper = SQLHelper();
  bool isButtonEnabled = false;
  Color buttonColor = Colors.grey; // Initial button color

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
      isButtonEnabled = true;
      if (tempNilai != null) {
        print("oke : $tempNilai");
        print("temp : $tempNilai");
        if (tempNilai > 100) {
          isButtonEnabled = false;
          // setState(() {
          //   // buttonColor = colorTheme(colorAccent); // Set the new button color
          // });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Input max 100.0'),
            ),
          );
        }
      } else {
        isButtonEnabled = false;

        print("error : $input");
        isButtonEnabled = false;
        // setState(() {
        //   buttonColor = colorTheme(colorAccent); // Set the new button color
        // });
      }
    } else {
      isButtonEnabled = false;
      // setState(() {
      //   buttonColor = colorTheme(colorAccent); // Set the new button color
      // });
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
      color: colorTheme(colorWhite),
      child: Column(
        children: [
          Material(
            elevation: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  TextField(
                    controller: _controllerNilai,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,1}')),
                    ],
                    decoration: InputDecoration(
                      hintText: "ex : 95.6, 70, etc",
                      label: Text("nilai (0 - 100)"),
                      labelStyle: TextStyle(
                        color: Colors.black, // Specify the label text color
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.solid)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                            color: colorTheme(
                                colorBlack)), // Border color when focused
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                            color: colorTheme(colorBlack,
                                opacity: 0.5)), // Border color when not focused
                      ),
                      filled: true,
                      fillColor: colorTheme(colorWhite),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: colorTheme(colorWhite)),
                      ),
                      onPressed: () {
                        addNotes(_controllerNilai.text.toString());
                        _controllerNilai.clear();
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            isButtonEnabled
                                ? colorTheme(colorBlack)
                                : colorTheme(colorAccent)), // Background color
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: colorTheme(colorAccent, opacity: 0.5),
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: ListView.builder(
                itemCount: listOfNotes.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    height: 50,
                    // color: colorTheme(colorBackground),
                    decoration: BoxDecoration(
                        color: colorTheme(colorWhite),
                        border: Border.all(
                          width: 3,
                          color: index % 3 == 0
                              ? colorTheme(colorGrizzly)
                              : index % 3 == 1
                                  ? colorTheme(colorIcebear)
                                  : colorTheme(colorPanda),
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    // color: index % 3 == 0
                    //     ? colorTheme(colorGrizzly)
                    //     : index % 3 == 1
                    //         ? colorTheme(colorIcebear)
                    //         : colorTheme(colorPanda),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nilai : ${listOfNotes[index].nilai}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Grade : ${listOfNotes[index].grade}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
