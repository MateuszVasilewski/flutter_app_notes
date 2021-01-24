import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/note/note_bloc.dart';

import 'components/note_card.dart';

class HomeBody extends StatelessWidget {
  final NotesLoaded loadedState;

  const HomeBody({this.loadedState, Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    if(loadedState.notes.isEmpty) {
      return const Center(child: Text("Your list is empty :c"));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(height: 10, thickness: 1,),
        itemCount: loadedState.notes.length,
        itemBuilder: (context, index) => NoteCard(note: loadedState.notes[index]),
      ),
    );
  }
}
