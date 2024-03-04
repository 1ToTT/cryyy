// db_table.dart
import 'package:path/path.dart' show join, dirname;
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class SqliteManager {
  final String _dbname = "datadata.db";
  final int _dbversion = 1;
  static final SqliteManager instance = SqliteManager._privateConstructor();

  late Database _database;

  SqliteManager._privateConstructor();

  Future<void> connect() async {
    try {
      String databasePath = await getDatabasesPath();
      String dbPath = join(databasePath, _dbname);

      // Open or create the database
      _database = await openDatabase(dbPath, version: _dbversion, onCreate: createDatabase);
    } catch (error) {
      print("Error while connecting to the database: $error");
      rethrow; // Rethrow the error to handle it in the caller
    }
  }

  Future<void> createDatabase(Database db, int version) async {
    try {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS TypeFinancial("
              "ID_type_financial INTEGER PRIMARY KEY AUTOINCREMENT,"
              "type_financial TEXT"
              ");");

      await db.execute(
          "CREATE TABLE IF NOT EXISTS Financial("
              "ID_financial INTEGER PRIMARY KEY AUTOINCREMENT,"
              "date_user TEXT,"
              "amount_financial DECIMAL,"
              "type_expense INTEGER,"
              "ID_type_financial INTEGER,"
              "memo_financial TEXT,"
              "FOREIGN KEY (ID_type_financial) REFERENCES TypeFinancial(ID_type_financial)"
              ");");

      await db.execute(
          "CREATE TABLE IF NOT EXISTS Budget("
              "ID_budget INTEGER PRIMARY KEY AUTOINCREMENT,"
              "capital_budget DECIMAL,"
              "ID_type_financial INTEGER,"
              "date_start TEXT,"
              "date_end TEXT,"
              "FOREIGN KEY (ID_type_financial) REFERENCES TypeFinancial(ID_type_financial)"
              ");");

      // เพิ่มข้อมูลเริ่มต้นในตาราง TypeFinancial
      await db.execute(
          "INSERT INTO TypeFinancial (type_financial) VALUES ('อาหารเครื่องดิ่ม'), ('ค่าเดินทาง'), ('ค่าสาธารณูปโภค');");
    } catch (error) {
      print("Error while creating database: $error");
      rethrow;
    }
  }

  Future<void> insertData(String tableName, Map<String, dynamic> data) async {
    await connect();
    try {
      await _database.insert(tableName, data);
    } catch (error) {
      print("Error while inserting data into $tableName: $error");
      rethrow;
    }
  }

  Future<void> updateData(String tableName, Map<String, dynamic> data, int id) async {
    await connect();
    try {
      await _database.update(tableName, data, where: 'ID_financial = ?', whereArgs: [id]);
    } catch (error) {
      print("Error while updating data in $tableName: $error");
      rethrow;
    }
  }

  Future<void> deleteData(String tableName, int id) async {
    await connect();
    try {
      await _database.delete(tableName, where: 'ID_financial = ?', whereArgs: [id]);
    } catch (error) {
      print("Error while deleting data from $tableName: $error");
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> queryDatabase(String sqlString) async {
    await connect();
    try {
      return await _database.rawQuery(sqlString);
    } catch (error) {
      print("Error while querying database: $error");
      return [];
    }
  }

  Future<void> closeDatabase() async {
    try {
      await _database.close();
    } catch (error) {
      print("Error while closing the database: $error");
      rethrow;
    }
  }
  //*************************
  Future<List<Map<String, dynamic>>> getTypeFinancialData() async {
    try {
      return await _database.query('TypeFinancial');
    } catch (error) {
      print("Error fetching TypeFinancial data: $error");
      return [];
    }
  }


  // เพิ่มเมธอด insertTypeFinancial เพื่อเพิ่มข้อมูล TypeFinancial ในฐานข้อมูล
  Future<void> insertTypeFinancial(String typeFinancial) async {
    final data = {'type_financial': typeFinancial};
    await insertData('TypeFinancial', data);
  }
}
