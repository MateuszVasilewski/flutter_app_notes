import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_app/bloc/note/note_bloc.dart';
import 'package:flutter_app/model/database/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moor/moor.dart';

import 'mocks.dart';

void main() {
  final RepositoryMock _repositoryMock = RepositoryMock();
  const String noteString = "Hello world";

  final NoteCompanion testNoteCompanion = NoteCompanion(
      note: const Value<String>(noteString),
      id: const Value<int>(1),
      date: Value<DateTime>(DateTime.now())
  );

  group("LoadNoteEvent test", () {
    blocTest("Everything goes well, yield NotesLoading, NotesLoaded",
        build: () {
          when(_repositoryMock.getAllNotes())
              .thenAnswer((_) async => <NoteData>[]);
          return NoteBloc(_repositoryMock);
        },
        act: (NoteBloc bloc) => bloc.add(LoadNotesEvent()),
        expect: [NotesLoading(), NotesLoaded(const <NoteData>[])],
        verify: (_) {
          verify(_repositoryMock.getAllNotes())
              .called(1);
        });
    blocTest("Repository throws exception, yield NotesLoading, NotesLoadingError",
        build: () {
          when(_repositoryMock.getAllNotes())
              .thenThrow(Exception());
          return NoteBloc(_repositoryMock);
        },
        act: (NoteBloc bloc) => bloc.add(LoadNotesEvent()),
        expect: [NotesLoading(), NotesLoadingError()],
        verify: (_) {
          verify(_repositoryMock.getAllNotes())
              .called(1);
        });
  });

  group("AddNoteEvent test", () {
    blocTest("Everything goes well, yield AddingNote, NotesLoaded",
        build: () {
          when(NoteCompanion.insert(note: noteString, date: DateTime.now()))
              .thenAnswer((_) => testNoteCompanion);
          when(_repositoryMock.addNote(testNoteCompanion))
              .thenAnswer((_) => null);
          return NoteBloc(_repositoryMock);
        },
        act: (NoteBloc bloc) => bloc.add(AddNoteEvent(noteString)),
        expect: [AddingNote(), NotesLoaded(<NoteData>[NoteData(
          note: testNoteCompanion.note.value,
          id: testNoteCompanion.id.value,
          date: testNoteCompanion.date.value
        )])],
        verify: (_) {
          verify(_repositoryMock.addNote(testNoteCompanion))
              .called(1);
        });

    blocTest("Repository throws exception when previous state doesnt have notes"
        " yield AddingNote, AddingNoteError, NotesLoadingError",
        build: () {
          when(NoteCompanion.insert(note: noteString, date: DateTime.now()))
              .thenAnswer((_) => testNoteCompanion);
          when(_repositoryMock.addNote(testNoteCompanion))
              .thenThrow(Exception());
          return NoteBloc(_repositoryMock);
        },
        act: (NoteBloc bloc) => bloc.add(AddNoteEvent(noteString)),
        expect: [AddingNote(), AddingNoteError(), NotesLoadingError()],
        verify: (_) {
          verify(_repositoryMock.addNote(testNoteCompanion))
              .called(1);
        });

    blocTest("Repository throws exception when previous state has notes"
        " yield AddingNote, AddingNoteError, NotesLoaded",
        build: () {
          when(_repositoryMock.getAllNotes())
              .thenAnswer((_) async => <NoteData>[]);
          when(NoteCompanion.insert(note: noteString, date: DateTime.now()))
              .thenAnswer((_) => testNoteCompanion);
          when(_repositoryMock.addNote(testNoteCompanion))
              .thenThrow(Exception());
          return NoteBloc(_repositoryMock)..add(LoadNotesEvent());
        },
        act: (NoteBloc bloc) => bloc.add(AddNoteEvent(noteString)),
        expect: [AddingNote(), AddingNoteError(), NotesLoaded(const <NoteData>[])],
        verify: (_) {
          verify(_repositoryMock.addNote(testNoteCompanion))
              .called(1);
        });
  });
}
