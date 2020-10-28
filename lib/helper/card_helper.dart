import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class CardHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'card.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE card(cardnumber TEXT,name TEXT,month INTEGER,year INTEGER,network TEXT,company TEXT)');
    }, version: 1);
  }

  static Future<void> addCard({
    String number,
    String name,
    int month,
    int year,
    String network,
    String company,
  }) async {
    final db = await CardHelper.database();
    db.insert('card', {
      'cardnumber': number,
      'name': name,
      'month': month,
      'year': year,
      'network': network,
      'company': company,
    });
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await CardHelper.database();
    return db.query('card');
  }
}
