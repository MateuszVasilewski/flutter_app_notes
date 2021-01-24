import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/note_display/note_display_cubit.dart';
import 'file:///C:/Projects/power_quotes/flutter_app/lib/ui/homescreen/components/home_body/home_body.dart';
import 'package:flutter_app/ui/homescreen/components/home_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),

      body: BlocBuilder<NoteDisplayCubit, NoteDisplayState>(
          builder: (context, state){
            if(state is NotesLoaded){
              return HomeBody(loadedState: state);
            }
            if(state is NotesLoadingError){
              return const HomeError();
            }
            if(state is NoteDisplayInitial) {
              BlocProvider.of<NoteDisplayCubit>(context).loadAllNotes();
            }
            return const Center(child: CircularProgressIndicator());
          }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
