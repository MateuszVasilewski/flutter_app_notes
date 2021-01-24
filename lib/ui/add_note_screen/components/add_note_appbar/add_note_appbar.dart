import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/note/note_bloc.dart';
import 'file:///C:/Projects/power_quotes/flutter_app/lib/ui/add_note_screen/components/add_note_appbar/components/add_note_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNoteAppbar extends StatelessWidget implements PreferredSizeWidget{
  final Function onPlusTap;

  const AddNoteAppbar({this.onPlusTap, Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: Navigator
            .of(context)
            .pop,
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      title: const Text("Add Note"),
      actions: [
        AddNoteButton(
          onTap: () => onPlusTap(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}
