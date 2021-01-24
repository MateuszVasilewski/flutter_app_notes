import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/note/note_bloc.dart';
import 'package:flutter_app/model/database/database.dart';
import 'package:flutter_app/model/repository.dart';
import 'package:flutter_app/ui/add_note_screen/add_note_screen.dart';
import 'package:flutter_app/ui/homescreen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Repository(Database()),
      child: BlocProvider(
        create: (context) => NoteBloc(RepositoryProvider.of(context)),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              '/home': (_) => const HomeScreen(),
              '/add': (_) => const AddNoteScreen(),
            },
            home: const HomeScreen()),
      ),
    );
  }
}
