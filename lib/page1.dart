import 'package:appapp/page1add_control.dart';
import 'package:flutter/material.dart';
import 'package:appapp/database/db_table.dart'; // import ไฟล์ที่มีคลาส SqliteManager

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<Map<String, dynamic>> _financialData = [];
  List<Map<String, dynamic>> _budgetData = [];
  @override
  void initState() {
    super.initState();
    _fetchFinancialData(); // เมื่อโหลดหน้าครั้งแรก ให้ดึงข้อมูลจากฐานข้อมูล
  }


  Future<void> _fetchFinancialData() async {
    try {
      List<Map<String, dynamic>> financialData = await SqliteManager.instance.queryDatabase('SELECT * FROM Financial');
      setState(() {
        _financialData = financialData;
      });
    } catch (error) {
      print("Error fetching financial data: $error");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: _financialData.isEmpty
          ? Center(child: Text('ไม่มีข้อมูล'))
          : ListView.builder(
        itemCount: _financialData.length,
        itemBuilder: (context, index) {
          final financial = _financialData[index];
          return ListTile(
            title: Text('วันที่: ${financial['date_user']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('จำนวนเงิน: ${financial['amount_financial']}'),
                Text('ประเภท: ${financial['ID_type_financial']}'),
                Text('หมายเหตุ: ${financial['memo_financial']}'),
                Text('รับจ่าย: ${financial['type_expense']}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                // ใส่โค้ดสำหรับลบข้อมูล
                await SqliteManager.instance.deleteData('Financial', financial['ID_financial']);
              },
            ),
          );
          return ListTile(
            title: Text('วันที่: ${financial['date_user']}'),
            subtitle: Text('จำนวนเงิน: ${financial['amount_financial']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // ใส่โค้ดสำหรับลบข้อมูลที่ต้องการที่นี่
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ไปยังหน้า Page1add
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFinancialPage()),
          ).then((_) {
            // เมื่อกลับมาจากหน้า Page1add ให้ดึงข้อมูลใหม่จากฐานข้อมูล
            _fetchFinancialData();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
