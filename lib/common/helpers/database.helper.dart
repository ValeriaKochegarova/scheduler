import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "deals.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    return await db.execute(
        "CREATE TABLE DealsTable(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, done TINYINT, date DATETIME, priority INTEGER)");
  }

  Future<List<Map<String, dynamic>>> getDealsByDate(date) async {
    var dbClient = await db;
    DateTime dayStart = DateTime(date.year, date.month, date.day, 0, 0, 0, 0);
    DateTime dayEnd = DateTime(date.year, date.month, date.day, 23, 59, 59, 0);
    return await dbClient.rawQuery(
        "SELECT * FROM DealsTable WHERE date BETWEEN '${dayStart.toString()}' AND '${dayEnd.toString()}'");
  }

  Future<List<Map<String, dynamic>>> getDealsByPeriod(period) async {
    Database dbClient = await db;
    return await dbClient.rawQuery(
        "SELECT * FROM DealsTable WHERE date BETWEEN '${period['from'].toString()}' AND '${period['to'].toString()}'");
  }

  Future<List<Map<String, dynamic>>> getFirstDeal() async {
    Database dbClient = await db;
    return await dbClient.query('DealsTable',
        columns: ['date'], orderBy: 'date ASC', limit: 1);
  }

  Future<int> createDeal(deal) async {
    Database dbClient = await db;
    Map<String, dynamic> clonedDeal = Map<String, dynamic>.from(deal);
    clonedDeal['date'] = clonedDeal['date'].toString();
    return await dbClient.insert('DealsTable', clonedDeal);
  }

  Future<int> updateDeal(Map<String, dynamic> deal) async {
    Database dbClient = await db;
    Map<String, dynamic> clonedDeal = Map<String, dynamic>.from(deal);
    int id = clonedDeal['id'];
    clonedDeal['date'] = clonedDeal['date'].toString();
    clonedDeal.remove('id');
    return await dbClient.update(
        'DealsTable', Map<String, dynamic>.from(clonedDeal),
        where: 'id = $id');
  }

  Future<int> deleteDeal(deal) async {
    Database dbClient = await db;
    return await dbClient
        .rawDelete("DELETE FROM DealsTable WHERE id = ${deal['id']}");
  }
}
