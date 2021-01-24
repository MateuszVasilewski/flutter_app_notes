part of 'note_display_cubit.dart';

@immutable
abstract class NoteDisplayState extends Equatable{
  @override
  List<Object> get props => [];
}

class NoteDisplayInitial extends NoteDisplayState {}

class NotesLoading extends NoteDisplayState {}

class NotesLoaded extends NoteDisplayState {
  final List<NoteData> notes;

  NotesLoaded(this.notes);

  @override
  List<Object> get props => [notes];
}

class NotesLoadingError extends NoteDisplayState {}
