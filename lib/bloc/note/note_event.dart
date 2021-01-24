part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class LoadNotesEvent extends NoteEvent{}

class AddNoteEvent extends NoteEvent{
  final String noteString;

  AddNoteEvent(this.noteString);
}