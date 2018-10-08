import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "deals.db");
    var dealsDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    if (dealsDb == null) {
      await createTableDeals();
      dealsDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    }
    return dealsDb;
  }

  Future _onCreate(Database db, int version) async {
    var exec = await db.execute(
        "CREATE TABLE DealsTable(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, done TINYINT, date DATETIME, priority INTEGER)");
    return exec;
  }

  Future<int> createTableDeals() async {
    var dbClient = await db;

    int result = await dbClient.execute(
        "CREATE TABLE DealsTable(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, done TINYINT, date DATETIME, priority INTEGER)");
    return result;
  }

  // add deal
  Future saveDeals(deals) async {
    var dbClient = await db;
    for (var f in deals) {
      var text = f['text'];
      var done = f['done'];
      var date = f['date'];
      var priority = f['priority'];
      try {
        dbClient.execute(
            "ISERT INTO DealsTable (id, text, done, date, priority) VALUES ($text, $done, $date, $priority)");
      } catch (err) {
        print('sqflite error => $err');
      }
    }
  }

  Future getDealsByDate(date) async {
    print(date);
    print(date is String);
    var dbClient = await db;
    DateTime dateObj = DateTime.parse(date);
    DateTime dayStart =
        new DateTime(dateObj.year, dateObj.month, dateObj.day, 0, 0, 0, 0);
    DateTime dayEnd =
        new DateTime(dateObj.year, dateObj.month, dateObj.day, 23, 59, 59, 0);

    var result = await dbClient.rawQuery(
        "SELECT * FROM DealsTable WHERE date BETWEEN '${dayStart.toString()}' AND '${dayEnd.toString()}'");
    print(result);
    return result;
  }

  Future<int> createDeal(dealItem) async {
    var dbClient = await db;
    Object result = await dbClient.insert('DealsTable', dealItem);
    return result;
  }

  //get deals
  Future<List> getDeals() async {
    var dbClient = await db;
    List result = await dbClient.rawQuery('SELECT * FROM DealsTable');
    return result;
  }

  //delete deals
  Future<int> removeDeals() async {
    var dbClient = await db;
    var result = await dbClient.rawDelete('DROP TABLE DealsTable');
    return result;
  }
}
