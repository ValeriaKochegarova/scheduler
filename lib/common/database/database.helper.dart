import 'package:scheduler_app/store/store.dart';
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
    Database database =
        await openDatabase(path, version: 1, onCreate: _onCreate);

    return database;
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

  Future getDealsByDate(date) async {
    var dbClient = await db;
    DateTime dayStart = DateTime(date.year, date.month, date.day, 0, 0, 0, 0);
    DateTime dayEnd = DateTime(date.year, date.month, date.day, 23, 59, 59, 0);

    var result = await dbClient.rawQuery(
        "SELECT * FROM DealsTable WHERE date BETWEEN '${dayStart.toString()}' AND '${dayEnd.toString()}'");
    return result;
  }

  Future<int> createDeal(deal) async {
    var dbClient = await db;
    Map<String, dynamic> clonedDeal = Map<String, dynamic>.from(deal);
    clonedDeal['date'] = clonedDeal['date'].toString();
    int id = await dbClient.insert('DealsTable', clonedDeal);
    return id;
  }

  // Future markDoneDeal(deal) async {
  //   var dbClient = await db;
  //   var updatedDeal = await dbClient.rawUpdate(
  //       "UPDATE DealsTable set done = '${deal['done']}' WHERE id = ${deal['id']}");
  //   return updatedDeal;
  // }

  Future updateDeal(Map<String, dynamic> deal) async {
    var dbClient = await db;
    Map<String, dynamic> clonedDeal = Map<String, dynamic>.from(deal);
    int id = clonedDeal['id'];
    clonedDeal['date'] = clonedDeal['date'].toString();
    clonedDeal.remove('id');
    var updatedDeal = await dbClient.update(
        'DealsTable', Map<String, dynamic>.from(clonedDeal),
        where: 'id = $id');
    return updatedDeal;
  }

  Future deleteDeal(deal) async {
    var dbClient = await db;
    var deletedDeal = await dbClient
        .rawDelete("DELETE FROM DealsTable WHERE id = ${deal['id']}");
    return deletedDeal;
  }

  //delete deals
  Future<int> removeDeals() async {
    var dbClient = await db;
    var result = await dbClient.rawDelete('DROP TABLE DealsTable');
    return result;
  }
}
