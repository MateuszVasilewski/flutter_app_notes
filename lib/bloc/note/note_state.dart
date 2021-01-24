part of 'note_bloc.dart';

@immutable
abstract class NoteState extends Equatable{
  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NotesLoading extends NoteState {}

class NotesLoaded extends NoteState {
  final List<NoteData> notes;

  NotesLoaded(this.notes);

  @override
  List<Object> get props => [notes];
}

class NotesLoadingError extends NoteState {}

class AddingNote extends NoteState {}

class AddingNoteError extends NoteState {}
