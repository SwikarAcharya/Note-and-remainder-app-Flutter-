import 'package:flutter/material.dart';

class ManageNotes extends StatelessWidget {
  const ManageNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Image.asset(
              'images/note.gif',
              height: 50,
              width: 50,
            ),
          ),
          Form(
              child: TextFormField(
            decoration: InputDecoration(hintText: 'Set the form title'),
          )),
          TextField(
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: 11,
            decoration: InputDecoration(hintText: 'Note here'),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Text('Sun Dec 19th, 2021'),
              ),
              Icon(
                Icons.add_box_rounded,
                size: 40,
                // color: Colors.amber,
              ),
            ],
          )
        ],
      ),
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.amber.shade300,
      ),
    );
  }
}
