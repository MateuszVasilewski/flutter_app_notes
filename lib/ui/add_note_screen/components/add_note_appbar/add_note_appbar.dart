import 'package:flutter/material.dart';
import 'package:flutter_app/ui/add_note_screen/components/add_note_appbar/components/add_note_button.dart';

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
