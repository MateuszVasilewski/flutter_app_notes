import 'package:flutter_app/model/database/dao/note.dart';
import 'package:flutter_app/model/database/database.dart';

class Repository{
  final Database database;

  const Repository(this.database);

  Future<List<NoteData>> getAllNotes() =>
      database.noteDao.getAll();

  Future<void> addNote(NoteCompanion data) =>
      database.noteDao.insertOne(data);
}