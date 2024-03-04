import 'package:flutter/material.dart';
import 'database/db_table.dart';
import 'page2.dart';
import 'page3.dart';
import 'page1.dart';
import 'page4.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  // Initialize sqflite FFI before using it
  sqfliteFfiInit();

  // Set databaseFactory to sqflite FFI
  databaseFactory = databaseFactoryFfi;

  // Connect to SQLite database and create tables
  SqliteManager sqliteManager = SqliteManager.instance;
  await sqliteManager.connect(); // เรียกใช้งานเมทอด connect() เพื่อเชื่อมต่อฐานข้อมูลและสร้างตาราง
  await _insertBasicFinancialTypes(); // Call the function to insert basic financial types

  // Check if data is inserted into TypeFinancial table
  List<Map<String, dynamic>> typeFinancialData = await sqliteManager.queryDatabase('SELECT * FROM TypeFinancial');
  if (typeFinancialData.isNotEmpty) {
    print('Data has been successfully inserted into TypeFinancial table.');
  } else {
    print('Data insertion into TypeFinancial table failed.');
  }

  runApp(MyApp());
}



// Function to insert basic financial types into TypeFinancial table
Future<void> _insertBasicFinancialTypes() async {
  // Insert financial types if the TypeFinancial table is empty
  List<Map<String, dynamic>> typeFinancialData = await SqliteManager.instance.queryDatabase('SELECT * FROM TypeFinancial');
  if (typeFinancialData.isEmpty) {
    await SqliteManager.instance.insertTypeFinancial('ค่าอาหารเครื่องดิ่ม');
    await SqliteManager.instance.insertTypeFinancial('ค่าเดินทาง');
    await SqliteManager.instance.insertTypeFinancial('ค่าสาธารณูปโภค');
    await SqliteManager.instance.insertTypeFinancial('ค่าเสื้อผ้า');
  }

}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Page1(),
    Page2(),
    Page3(),
    Page4(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightGreenAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Page 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Page 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_document),
            label: 'Page 4',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        selectedIconTheme: IconThemeData(color: Colors.black),
      ),
    ),
  );
}
