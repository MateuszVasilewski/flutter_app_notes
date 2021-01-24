part of 'add_note_cubit.dart';

@immutable
abstract class AddNoteState extends Equatable{
  @override
  List<Object> get props => [];
}

class AddNoteInitial extends AddNoteState {}

class AddingNote extends AddNoteState {}

class NoteAdded extends AddNoteState {}

class AddingNoteError extends AddNoteState {}