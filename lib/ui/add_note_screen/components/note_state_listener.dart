import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/note/note_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteStateListener extends StatelessWidget {
  final Widget child;

  const NoteStateListener({@required this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteBloc, NoteState>(
      listenWhen: _listenWhen,
      listener: _listener,
      child: child,
    );
  }

  bool _listenWhen(NoteState previous, NoteState current) =>
      current is AddingNoteError || current is NotesLoaded;

  void _listener(BuildContext context, NoteState state) {
    if (state is AddingNoteError) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong'),
      ));
    }
    if (state is NotesLoaded) {
      Navigator.of(context).pop();
    }
  }
}
