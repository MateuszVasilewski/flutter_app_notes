import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/model/database/dao/note.dart';
import 'package:flutter_app/model/database/database.dart';
import 'package:flutter_app/model/repository.dart';
import 'package:meta/meta.dart';

part 'note_event.dart';

part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final Repository _repository;

  NoteBloc(this._repository) : super(NoteInitial());

  @override
  Stream<NoteState> mapEventToState(
    NoteEvent event,
  ) async* {
    if (event is AddNoteEvent) {
      yield* mapAddNoteEventToState(event);
    }
    if (event is LoadNotesEvent) {
      yield* mapLoadNotesEventToState(event);
    }
  }

  Stream<NoteState> mapAddNoteEventToState(AddNoteEvent event) async* {
    yield AddingNote();
    List<NoteData> resultNotes;
    if (state is NotesLoaded) {
      resultNotes = List<NoteData>.from((state as NotesLoaded).notes);
    } else {
      resultNotes = [];
    }

    try {
      final NoteCompanion note =
          NoteCompanion.insert(note: event.noteString, date: DateTime.now());
      await _repository.addNote(note);
      resultNotes.add(NoteData(
        note: note.note.value,
        id: note.id.value,
        date: note.date.value,
      ));
      yield NotesLoaded(resultNotes);
      return;
    } catch (ex) {
      yield AddingNoteError();
      if (resultNotes == null) {
        yield NotesLoadingError();
      } else {
        yield NotesLoaded(resultNotes);
      }
    }
  }

  Stream<NoteState> mapLoadNotesEventToState(LoadNotesEvent event) async* {
    yield NotesLoading();
    try {
      final List<NoteData> notes = await _repository.getAllNotes();
      yield NotesLoaded(notes);
    } catch (ex) {
      yield NotesLoadingError();
    }
  }
}
