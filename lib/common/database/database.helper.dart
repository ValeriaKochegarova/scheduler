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
    print(path);
    var dealsDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    if (dealsDb == null) {
      var dbClient = await db;
      await _onCreate(dbClient, 1);
      dealsDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    }
    return dealsDb;
  }

  Future _onCreate(Database db, int version) async {
    var exec = await db.execute(
        "CREATE TABLE DealsTable(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, done TINYINT, date DATETIME, priority INTEGER)");
    return exec;
  }

  // Future<int> createTableDeals() async {
  //   var dbClient = await db;
  //   int result = await dbClient.execute(
  //       "CREATE TABLE DealsTable(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, done TINYINT, date DATETIME, priority INTEGER)");
  //   return result;
  // }

  Future getDealsByDate(date) async {
    var dbClient = await db;
    DateTime dayStart =
        new DateTime(date.year, date.month, date.day, 0, 0, 0, 0);
    DateTime dayEnd =
        new DateTime(date.year, date.month, date.day, 23, 59, 59, 0);

    var result = await dbClient.rawQuery(
        "SELECT * FROM DealsTable WHERE date BETWEEN '${dayStart.toString()}' AND '${dayEnd.toString()}'");
    return result;
  }

  Future<int> createDeal(dealItem) async {
    var dbClient = await db;
    dealItem['date'] = dealItem['date'].toString();
    print(dealItem is Map);
    int id = await dbClient.insert('DealsTable', Map<String, dynamic>.from(dealItem));
    return id;
  }

  Future markDoneDeal(deal) async {
    var dbClient = await db;
    var id = deal['id'];
    var done = deal['done'];
    var updatedDeal = await dbClient
        .rawUpdate("UPDATE DealsTable set done = '$done' WHERE id = $id");
    return updatedDeal;
  }

  //delete deals
  Future<int> removeDeals() async {
    var dbClient = await db;
    var result = await dbClient.rawDelete('DROP TABLE DealsTable');
    return result;
  }
}
