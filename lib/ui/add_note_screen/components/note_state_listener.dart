import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/note_add/add_note_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteStateListener extends StatelessWidget {
  final Widget child;

  const NoteStateListener({@required this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNoteCubit, AddNoteState>(
      listenWhen: _listenWhen,
      listener: _listener,
      child: child,
    );
  }

  bool _listenWhen(AddNoteState previous, AddNoteState current) =>
      current is NoteAdded || current is AddingNoteError;

  void _listener(BuildContext context, AddNoteState state) {
    if (state is AddingNoteError) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong'),
      ));
    }
    if (state is NoteAdded) {
      Navigator.of(context).pop();
    }
  }
}
