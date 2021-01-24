import 'package:flutter/material.dart';
import 'package:flutter_app/utils/date_extensions.dart';
import 'package:flutter_app/model/database/database.dart';

class NoteCard extends StatelessWidget {
  final NoteData note;

  const NoteCard({@required this.note, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(
              note.note,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 20,
          child: Text(
            note.date.stringValue,
            style: const TextStyle(color: Colors.grey),
          ),
        )
      ]),
    );
  }
}
