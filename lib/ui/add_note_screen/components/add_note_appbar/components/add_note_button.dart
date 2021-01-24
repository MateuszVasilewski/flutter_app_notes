import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/note/note_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNoteButton extends StatelessWidget {
  final Function onTap;

  const AddNoteButton({@required this.onTap, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<NoteBloc, NoteState>(
          buildWhen: _buildWhen,
          builder: (context, state) {
            if (state is AddingNote) {
              return const CircularProgressIndicator(backgroundColor: Colors.white,);
            }


            return InkWell(
              onTap: () => onTap(),
              child: const Center(child: Text("Save")),
            );
          }),
    );
  }

  bool _buildWhen(NoteState previous, NoteState current) =>
      current is AddingNote || previous is AddingNote;
}
