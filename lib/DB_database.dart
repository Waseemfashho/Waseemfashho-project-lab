import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static final String title = "title";
  static final String description = "description";
  static final String color = "color";
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE note(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        $title TEXT,
        $description TEXT,
        $color INTEGER,
        createdtime TEXT NOT NULL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'project.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(
      String title, String? descrption, int color) async {
    final db = await SQLHelper.db();

    final data = {'title': title, 'description': descrption, 'color': color};
    final id = await db.insert('note', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('note', orderBy: "id=?");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('note', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id, String title, String? descrption, int color) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': descrption,
      'color': color,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('note', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("note", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
