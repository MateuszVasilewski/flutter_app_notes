import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_app/bloc/note_display/note_display_cubit.dart';
import 'package:flutter_app/model/database/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

void main() {
  final RepositoryMock _repositoryMock = RepositoryMock();

  group("NoteDisplayBloc test", () {
    blocTest("Everything goes well, yield NotesLoading, NotesLoaded",
        build: () {
          when(_repositoryMock.getAllNotes())
              .thenAnswer((_) async => <NoteData>[]);
          return NoteDisplayCubit(_repositoryMock);
        },
        act: (NoteDisplayCubit cubit) => cubit.loadAllNotes(),
        expect: [NotesLoading(), NotesLoaded(const <NoteData>[])],
        verify: (_) {
          verify(_repositoryMock.getAllNotes())
              .called(1);
        });
    blocTest("Repository throws exception, yield NotesLoading, NotesLoadingError",
        build: () {
          when(_repositoryMock.getAllNotes())
              .thenThrow(Exception());
          return NoteDisplayCubit(_repositoryMock);
        },
        act: (NoteDisplayCubit cubit) => cubit.loadAllNotes(),
        expect: [NotesLoading(), NotesLoadingError()],
        verify: (_) {
          verify(_repositoryMock.getAllNotes())
              .called(1);
        });
  });
}
