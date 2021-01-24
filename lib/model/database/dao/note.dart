import 'package:flutter_app/model/database/database.dart';
import 'package:moor/moor.dart';

part 'note.g.dart';

class Note extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get note => text()();
  DateTimeColumn get date => dateTime()();
}

@UseDao(tables: [Note])
class NoteDao
    extends DatabaseAccessor<Database>
    with _$NoteDaoMixin {
  NoteDao(Database database) : super(database);

  Future<void> insertOne(Insertable<NoteData> entry) => into(note).insert(entry);

  Future<List<NoteData>> getAll() => select(note).get();
}
