// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last
import 'package:expense_tracker_v1/components/expense_tile.dart';
import 'package:expense_tracker_v1/pages/statistic_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../models/expense_data.dart';
import '../models/expense_item.dart';
import '../models/expense_summary.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  final newExpenseCentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //prepare the data

    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  //calculate week total
  String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    //sort from largest to lowest
    double total = 0;

    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

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
              decoration: InputDecoration(
                hintText: "EXPENSE NAME",
              ),
            ),
            //EXPENSE AMOUNT
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newExpenseAmountController,
                    decoration: InputDecoration(
                      hintText: "PHP",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: newExpenseCentController,
                    decoration: InputDecoration(
                      hintText: "CENTS",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
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
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty &&
        newExpenseCentController.text.isNotEmpty) {
      String amount =
          '${newExpenseAmountController.text}.${newExpenseCentController.text}';
      //ORIGINAL CODE IN CASE IT GOES SOUTH
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: amount,
        dateTime: DateTime.now(),
      );
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
      Navigator.pop(context);
      clear();
    }
  }

  //FOR CANCEL
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
    newExpenseCentController.clear();
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  final ExpenseSummary expenseSummary = ExpenseSummary(
    startOfWeek: DateTime.now(),
  );

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
              padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: Container(
                height: 122,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(7, 7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "EXPENSE",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        "TRACKER",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.bar_chart),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => StatisticPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'STATISTICS',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 60, 0, 0),
                  child: Text(
                    'EXPENSES',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ],
            ),
            //ORIGINAL CODE IN CASE IT GOES SOUTH
            Expanded(
              child: ListView.builder(
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  dateTime: value.getAllExpenseList()[index].dateTime,
                  amount: value.getAllExpenseList()[index].amount,
                  deleteTapped: (p0) => deleteExpense(
                    value.getAllExpenseList()[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
