// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:expense_tracker_v1/models/expense_summary.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../models/expense_data.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 194, 26),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                      child: Text(
                        'YOUR WEEKLY STATISTICS',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(7, 7),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(6, 6),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: ExpenseSummary(
                  startOfWeek: value.startOfWeekDate(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
