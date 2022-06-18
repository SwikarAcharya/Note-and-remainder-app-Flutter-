import 'package:flutter/material.dart';
import 'package:remainder_app_project/resource/color.dart';
import 'package:remainder_app_project/resource/global.dart';
import 'package:remainder_app_project/resource/hivemanager.dart';
import 'package:remainder_app_project/resource/managenotes.dart';
import 'package:remainder_app_project/resource/managenotessir.dart';
import 'package:remainder_app_project/resource/myNote.dart';
import 'package:remainder_app_project/resource/note.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List notes = <Note>[];

  getNotes() async {
    notes = await HiveManager.onGetNotes();
    setState(() {});
  }

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber.shade600,
          title: Text('Notes'),
        ),
        floatingActionButton: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.amber.shade600,
          child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (BuildContext context) {
                      return Managesir(
                        notes_manage_mod: NOTES_MANAGE_MOD.ADD,
                        note: new Note('', LIST_OF_COLORS[0], true,
                            DateTime.now().millisecondsSinceEpoch),
                      );
                    }).then((value) => getNotes());
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              )),
        ),
        body: ListView(
          children: [...notes.map((e) => MyNote(e))],
        ));
  }
}
