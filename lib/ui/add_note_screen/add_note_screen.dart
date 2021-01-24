import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/note_add/add_note_cubit.dart';
import 'package:flutter_app/ui/add_note_screen/components/add_note_appbar/add_note_appbar.dart';
import 'package:flutter_app/ui/add_note_screen/components/note_state_listener.dart';
import 'package:flutter_app/utils/input_decoration.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddNoteAppbar(
        onPlusTap: () => BlocProvider.of<AddNoteCubit>(context)
                .addNote(_controller.text, DateTime.now())
                .then((value) => _controller.clear()),
      ),
      body: NoteStateListener(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Center(
            child: TextField(
              controller: _controller,
              decoration: inputDecoration,
              minLines: 3,
              maxLines: null,
            ),
          ),
        ),
      ),
    );
  }
}
