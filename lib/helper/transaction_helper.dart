import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class TransactionHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 't.db'), onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE t_helper(title TEXT,amount INTEGER,date TEXT,category TEXT ,iconCode INTEGER,iconFamily TEXT,iconPackage TEXT,type INTEGER,imagePath TEXT)');
    }, version: 1);
  }

  static Future<void> insert(
      {String title,
      int amount,
      String date,
      String category,
      int iconCode,
      String iconFamily,
      String iconPackage,
      int type,
      String imagePath}) async {
    final db = await TransactionHelper.database();
    await db.insert('t_helper', {
      'title': title,
      'amount': amount,
      'date': date,
      'category': category,
      'iconCode': iconCode,
      'iconFamily': iconFamily,
      'iconPackage': iconPackage,
      'type': type,
      'imagePath': imagePath,
    });
  }

  static Future<void> delete(String date) async {
    final db = await TransactionHelper.database();
    await db.delete('t_helper', where: 'date=?', whereArgs: [date]);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await TransactionHelper.database();
    return db.query('t_helper');
  }
}
