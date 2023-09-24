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
        print("HAIII - ${_controllerNilai.text}");
        print("HAIII - ${_controllerNilai.text.trim()}");
        if (_controllerNilai.text.trim().isNotEmpty) {
          if (_controllerNilai.text == '.') {
            _controllerNilai.text = "0.";
          } else if (_controllerNilai.text.length > 1) {
            if (_controllerNilai.text[0] == '0' &&
                _controllerNilai.text[1] != '.') {
              _controllerNilai.text = _controllerNilai.text[1];
            }
          }
          isButtonEnabled = true;
        } else {
          isButtonEnabled = false;
        }
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _controllerNilai.dispose();
    super.dispose();
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
      } else {
        final newNote =
            NotesModel(nilai: tempNilai, grade: convertGrade(tempNilai));
        await sqlHelper.insertNotes(newNote);

        setState(() {
          _loadNotes();
        });
      }
    } catch (e) {}
  }

  Future<void> _resetNotes(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: colorTheme(colorWhite),
          contentPadding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          buttonPadding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text('Confirm Reset')),
              IconButton(
                padding: EdgeInsets.all(0),
                alignment: Alignment.topRight,
                icon: Icon(
                  Icons.close,
                  color: colorTheme(colorBlack),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          content: Text(
            "Are you sure you want to reset? All of your notes will be delete",
            style: TextStyle(color: colorTheme(colorBlack)),
          ),
          actions: <Widget>[
            Container(
              color: colorTheme(colorWhite),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await sqlHelper.deleteAllNotes();
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Text(
                  "Reset",
                  style: TextStyle(
                      color: colorTheme(colorWhite),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(colorTheme(colorAccent)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
        foregroundColor: colorTheme(colorWhite),
        backgroundColor: colorTheme(colorBlack),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                await _resetNotes(context);
                await _loadNotes();
                setState(() {});
              },
              icon: Icon(
                Icons.delete_forever_outlined,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Container(
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
                          RegExp(r'^(100|\d{0,2}(\.\d{0,1})?)'),
                        ),
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
                                  opacity:
                                      0.5)), // Border color when not focused
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
                          if (isButtonEnabled) {
                            addNotes(_controllerNilai.text.toString());
                            _controllerNilai.clear();
                          }
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
                                  : colorTheme(
                                      colorAccent)), // Background color
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
                            color: (listOfNotes.length - 1 - index) % 3 == 0
                                ? colorTheme(colorGrizzly)
                                : (listOfNotes.length - 1 - index) % 3 == 1
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
      ),
    );
  }
}
