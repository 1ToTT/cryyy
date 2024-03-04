import 'package:appapp/database/db_table.dart';

// void main() async {
//   final sqliteManager = SqliteManager.instance;
//   await sqliteManager.connect();
//
//   // เพิ่มข้อมูล
//   await sqliteManager.insertData('TypeFinancial', {'type_financial': 'เงินเดือน'});
//   await sqliteManager.insertData('TypeFinancial', {'type_financial': 'ค่าอาหาร'});
//   await sqliteManager.insertData('TypeFinancial', {'type_financial': 'ค่าเดินทาง'});
//   await sqliteManager.insertData('TypeFinancial', {'type_financial': 'อื่นๆ'});
//
//   // await sqliteManager.closeDatabase();
// }
// เรียกใช้เมทอด insertData ในคลาส SqliteManager
final sqliteManager = SqliteManager.instance;
final Map<String, dynamic> financialData = {
  'date_user': '2024-03-03', // ตัวอย่างเท่านั้น คุณควรดึงวันที่จริงจากการป้อนข้อมูลจากผู้ใช้
  'amount_financial': 100.50, // ตัวอย่างเท่านั้น คุณควรดึงจำนวนจริงจากการป้อนข้อมูลจากผู้ใช้
  'type_expense': 1, // ตัวอย่างเท่านั้น คุณควรดึงค่าจากการป้อนข้อมูลจากผู้ใช้
  'ID_type_financial': 1, // ตัวอย่างเท่านั้น คุณควรดึงค่าจากการป้อนข้อมูลจากผู้ใช้
  'memo_financial': 'Expense for groceries', // ตัวอย่างเท่านั้น คุณควรดึงข้อมูลจากการป้อนข้อมูลจากผู้ใช้
};

// บันทึกข้อมูลลงในตาราง Financial
await sqliteManager.insertData('Financial', financialData);
