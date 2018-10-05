import 'package:flutter_test/flutter_test.dart';

class DatabasHelper {
  static final DatabasHelper _instance = DatabasHelper.internal();
  factory DatabasHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if(_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }


  DatabasHelper.internal();


  initDb() async {
    io.Directory documentDirectory = await gitApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "notes.db");
    var notesDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    if(notesDb == null) {
      await createTableNotes();
      notesDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    }
    return notesDb;
  }

  Future _onCreate(Database db, int version) async {
    var exec = await db.execute(
      "CREATE TABLE DealsTable(id INTEGER PRIMARY KEY"
    )
  }





}