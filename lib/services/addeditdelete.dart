import 'package:sqflite/sqflite.dart';

class SqliteOperations {
  final Database _database;

  SqliteOperations(this._database);

  // Insert data
  Future<void> insertData(String tableName, Map<String, dynamic> data) async {
    await _database.insert(tableName, data);
  }

  // Update data
  Future<void> updateData(String tableName, Map<String, dynamic> data, String whereClause) async {
    await _database.update(tableName, data, where: whereClause);
  }

  // Delete data
  Future<void> deleteData(String tableName, String whereClause) async {
    await _database.delete(tableName, where: whereClause);
  }
}
