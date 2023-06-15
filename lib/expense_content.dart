// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:expense_tracker_v1/models/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseContent extends StatefulWidget {
  const ExpenseContent({
    super.key,
    
  });

  @override
  State<ExpenseContent> createState() => _ExpenseContentState();
}

class _ExpenseContentState extends State<ExpenseContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        body: ListView.builder(
          itemCount: value.getAllExpenseList().length,
          itemBuilder: (content, index) => ListTile(
            title: Text(value.getAllExpenseList()[index].name, style: TextStyle(),),
            subtitle: Text(value.getAllExpenseList()[index].dateTime.toString()),
            trailing: Text('PHP${value.getAllExpenseList()[index].amount}'),
          ),
        ),
      ),
    );
  }
}
