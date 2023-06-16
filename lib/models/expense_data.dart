import 'package:expense_tracker_v1/models/date_time_helper.dart';
import 'package:expense_tracker_v1/models/hive_database.dart';
import 'package:flutter/material.dart';
import 'expense_item.dart';

class ExpenseData extends ChangeNotifier {
  // list of ALL EXPENSES
  List<ExpenseItem> overallExpenseList = [];

  // GET EXPENSE LIST
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

//prepare the data to display
  final db = HiveDatabase();
  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  // ADD NEW EXPENSE
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //DELETE EXPENSE
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //GET WEEKDAY (MON TUES ETC) FROM A DATE TIME OBJECT
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thurs';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // GET THE DATE FOR THE START OF THE WEEK
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    //GET TODAY'S DATE
    DateTime today = DateTime.now();

    //Go backwards from today to find sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }
  /* 

  CONVERT OVERALL LIST OF EXPENSES INTO A DAILY EXPENSE SUMMARY

  E.G 

  overallExpenseList = [

    [ food, 2023/6/14, php 60.00]
    [ drinks, 2023/6/15, php 60.00]
    [ school, 2023/6/16, php 60.00]
    [ food, 2023/6/18, php 60.00]
    [ food, 2023/6/17, php 60.00]

  ]

  DailyExpenseSummary = 

  [

    [ 2023/6/14: 60]
    [ 2023/6/15: 60]
    [ 2023/6/16: 60]
    [ 2023/6/17: 60]

  ]
  */

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      // date (yyyymmdd) : amountTotalforDAY
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }

  void setOverallExpenseList(List<ExpenseItem> expenses) {}
}
