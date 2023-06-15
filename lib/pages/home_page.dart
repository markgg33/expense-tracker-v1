// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:expense_tracker_v1/components/expense_tile.dart';
import 'package:expense_tracker_v1/pages/statistic_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense_data.dart';
import '../models/expense_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("ADD NEW EXPENSE"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //EXPENSE NAME
            TextField(
              controller: newExpenseNameController,
            ),
            //EXPENSE AMOUNT
            TextField(
              controller: newExpenseAmountController,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 252, 206, 1),
                border: Border.all(width: 2),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(6, 6),
                  ),
                ],
              ),
              child: MaterialButton(
                onPressed: save,
                child: Text('SAVE'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(6, 6),
                  ),
                ],
              ),
              child: MaterialButton(
                onPressed: cancel,
                child: Text('CANCEL'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //FOR SAVE
  void save() {
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.pop(context);
    clear();
  }

  //FOR CANCEL
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 194, 26),
        floatingActionButton: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(width: 2),
            boxShadow: [
              BoxShadow(offset: Offset(6, 6)),
            ],
          ),
          child: FloatingActionButton(
            onPressed: addNewExpense,
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
              child: Container(
                height: 100,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    border: Border.all(width: 2),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(7, 7),
                      ),
                    ]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                  child: Icon(Icons.bar_chart),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StatisticPage(),
                        ),
                      );
                    },
                    child: Text(
                      'SEE STATISTICS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    'EXPENSES',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  dateTime: value.getAllExpenseList()[index].dateTime,
                  amount: value.getAllExpenseList()[index].amount,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
