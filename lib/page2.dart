import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Page2 extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) => Scaffold(
    key: _scaffoldKey,
    appBar: AppBar(title: Text('Static Chart')),
    body: Center(
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: DateTime.now(),
            // ... other properties
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: Icon(Icons.bar_chart),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Chart'),

                      ),
                    );
                  },
                  iconSize: 60,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('รายการ'),

                    ),
                  );},
                  iconSize: 60,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: Icon(Icons.scale),
                  onPressed: () {
                    // Show a SnackBar with the message "compare"
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('compare'),

                      ),
                    );
                  },
                  iconSize: 60,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          // Add a Text widget to display the message below the buttons
          Text(
            'Click the third button to see "compare"',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
