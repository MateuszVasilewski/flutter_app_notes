import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/note_add/add_note_cubit.dart';
import 'package:flutter_app/bloc/note_display/note_display_cubit.dart';
import 'package:flutter_app/model/database/database.dart';
import 'package:flutter_app/model/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalProviders extends StatelessWidget {
  final Widget child;

  const GlobalProviders({@required this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(Database()),
      child: BlocProvider(
        create: (context) => NoteDisplayCubit(RepositoryProvider.of(context)),
        child: Builder(builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => AddNoteCubit(
              RepositoryProvider.of(context),
              () => BlocProvider.of<NoteDisplayCubit>(context).loadAllNotes(),
            ),
            child: child,
          );
        }),
      ),
    );
  }
}
