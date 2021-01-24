import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/model/database/database.dart';
import 'package:flutter_app/model/repository.dart';
import 'package:meta/meta.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  final Repository _repository;
  final Function _notifyDisplay;

  AddNoteCubit(this._repository, this._notifyDisplay) : super(AddNoteInitial());

  Future<void> addNote(String noteString, DateTime date) async {
    emit(AddingNote());
    try {
      await _repository.addNote(
          NoteCompanion.insert(note: noteString, date: date));
      emit(NoteAdded());
      _notifyDisplay();
    } catch (ex) {
      emit(AddingNoteError());
    }
  }
}
