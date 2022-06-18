import 'package:flutter/material.dart';
import 'package:nepali_utils/src/nepali_date_time.dart';
import 'package:remainder_app_project/resource/global.dart';
import 'package:remainder_app_project/resource/managenotessir.dart';
import 'package:remainder_app_project/resource/note.dart';

class MyNote extends StatelessWidget {
  Note note;
  MyNote(this.note);

  getIconByTime(int noteDate, BuildContext context) {
    int todayDate = DateTime.now().millisecondsSinceEpoch;
    if (todayDate > noteDate) {
      return Icon(
        Icons.check_circle_outline_rounded,
        color: Colors.green.shade800,
      );
    } else {
      return InkWell(
        onTap: () => {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Managesir(
                  note: note,
                  notes_manage_mod: NOTES_MANAGE_MOD.EDIT,
                );
              })
        },
        child: Icon(
          Icons.edit,
          color: Colors.yellow.shade800,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(
        top: (20),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(note.selectedColor)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  note.notes == null ? "" : note.notes,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.alarm_add_rounded,
                      color: Colors.red.shade600,
                    ),
                    //SizedBox(
                    // width: MediaQuery.of(context).size.width / 2.2,
                    // ),
                    Text(
                      // note.notificationDate == null
                      //     ? ''
                      //     : DateTime.fromMillisecondsSinceEpoch(
                      //             note.notificationDate)
                      //         .toNepaliDateTime()
                      //         .toString(),
                      // 'hi',
                      note.notificationDate.toString(),
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          getIconByTime(note.notificationDate, context),
        ],
      ),
    );
  }
}
