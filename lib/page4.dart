import 'package:flutter/material.dart';
import 'package:appapp/add_budget.dart'; // Import the AddBudgetPage

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 4'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the add budget page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddBudgetPage()),
            );
          },
          child: Text('Create a Budget'),
        ),
      ),
    );
  }
}
