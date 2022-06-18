import 'package:flutter/material.dart';
import 'package:remainder_app_project/resource/color.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:remainder_app_project/resource/global.dart';
import 'package:remainder_app_project/resource/hivemanager.dart';
import 'package:remainder_app_project/resource/note.dart';

class Managesir extends StatefulWidget {
  late Note note;
  NOTES_MANAGE_MOD notes_manage_mod = NOTES_MANAGE_MOD.ADD;
  Managesir({Key? key, required this.note, required this.notes_manage_mod});

  @override
  State<Managesir> createState() => _ManagesirState();
}

class _ManagesirState extends State<Managesir> {
  int selectedColor = LIST_OF_COLORS[0];
  bool wantRem = true;
  NepaliDateTime? _selectedDateTime = NepaliDateTime.now();
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    textEditingController.text = widget.note.notes;
    selectedColor = widget.note.selectedColor;
    _selectedDateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.note.notificationDate)
            .toNepaliDateTime();
    wantRem = widget.note.wantRem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Form(
                      child: TextFormField(
                    controller: textEditingController,
                    maxLines: 10,
                    decoration: InputDecoration(
                        hintText: 'Enter your note',
                        filled: true,
                        fillColor: Color(selectedColor),
                        border: InputBorder.none,
                        labelText: 'Enter notes'),
                  )),
                  SizedBox(height: 20),
                  Text(
                    'Select colour for note',
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      ...LIST_OF_COLORS.map(
                        (e) => InkWell(
                          onTap: () {
                            selectedColor = e;
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 40,
                            width: 40,
                            child: selectedColor == e
                                ? Icon(Icons.check_box_outline_blank_outlined)
                                : SizedBox.shrink(),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(e),
                                border: Border.all(color: Colors.grey)),
                          ),
                        ),
                      )
                    ]),
                  ),
                  InkWell(
                    onTap: () {
                      wantRem = !wantRem;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        wantRem
                            ? Icon(Icons.check_box)
                            : Icon(Icons.crop_square_sharp),
                        SizedBox(width: 10),
                        Text('Set Remainder')
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      _selectedDateTime = await showMaterialDatePicker(
                        context: context,
                        initialDate: _selectedDateTime ?? NepaliDateTime.now(),
                        firstDate: NepaliDateTime(1970, 2, 5),
                        lastDate: NepaliDateTime(2099, 11, 6),
                        initialDatePickerMode: DatePickerMode.day,
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Pick date',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Expanded(child: SizedBox()),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                                onPressed: () async {
                                  print(textEditingController.text);
                                  if (widget.notes_manage_mod ==
                                      NOTES_MANAGE_MOD.ADD) {
                                    await HiveManager.onAddNotes(
                                        notes: textEditingController.text,
                                        notification: wantRem,
                                        selectedColor: selectedColor,
                                        date: _selectedDateTime!
                                            .microsecondsSinceEpoch);
                                  } else {
                                    print('Update');
                                  }

                                  Navigator.of(context).pop();
                                },
                                child: Text('Add')))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
