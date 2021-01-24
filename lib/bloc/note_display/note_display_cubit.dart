import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/model/database/database.dart';
import 'package:flutter_app/model/repository.dart';
import 'package:meta/meta.dart';

part 'note_display_state.dart';

class NoteDisplayCubit extends Cubit<NoteDisplayState> {
  final Repository _repository;

  NoteDisplayCubit(this._repository) : super(NoteDisplayInitial());

  Future<void> loadAllNotes() async{
    emit(NotesLoading());
    try {
      final List<NoteData> notes = await _repository.getAllNotes();
      emit(NotesLoaded(notes));
    } catch (ex) {
      emit(NotesLoadingError());
    }
  }
}
