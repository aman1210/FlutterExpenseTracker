import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class CategoryHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'category.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE category_todo(iconCode INTEGER, iconFamily TEXT,iconPackage TEXT,type INTEGER,title TEXT)');
    }, version: 1);
  }

  static Future<void> inserting({
    String table,
    int iconCode,
    String iconFamily,
    String iconPackage,
    int type,
    String title,
  }) async {
    final db = await CategoryHelper.database();
    await db.insert(table, {
      'iconCode': iconCode,
      'iconFamily': iconFamily,
      'iconPackage': iconPackage,
      'type': type,
      'title': title,
    });
  }

  // static Future<void> deleteCategory(String table, String title) async {
  //   final db = await CategoryHelper.database();
  //   await db.delete(table, where: 'title=?', whereArgs: [title]);
  // }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await CategoryHelper.database();
    return db.query(table);
  }
}
