import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_app/bloc/note_add/add_note_cubit.dart';
import 'package:flutter_app/model/database/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

void main() {
  final RepositoryMock _repositoryMock = RepositoryMock();
  const String noteString = "Hello world";
  final DateTime date = DateTime.now();


  group("AddNoteTest test", () {
    blocTest("Everything goes well, yield AddingNote, NoteAdded",
        build: () {
          when(_repositoryMock.addNote(
                  NoteCompanion.insert(note: noteString, date: date)))
              .thenAnswer((_) async => null);
          return AddNoteCubit(_repositoryMock, () {});
        },
        act: (AddNoteCubit cubit) => cubit.addNote(noteString, date),
        expect: [AddingNote(), NoteAdded()],
        verify: (_) {
          verify(_repositoryMock.addNote(
              NoteCompanion.insert(note: noteString, date: date))).called(1);
        });
    blocTest(
        "Repository throws exception, yield AddingNote, AddingNoteError",
        build: () {
          when(_repositoryMock.addNote(
              NoteCompanion.insert(note: noteString, date: date)))
              .thenThrow(Exception());
          return AddNoteCubit(_repositoryMock, (){});
        },
        act: (AddNoteCubit cubit) => cubit.addNote(noteString, date),
        expect: [AddingNote(), AddingNoteError()],
        verify: (_) {
          verify(_repositoryMock.addNote(
              NoteCompanion.insert(note: noteString, date: date))).called(1);
        });
  });
}
