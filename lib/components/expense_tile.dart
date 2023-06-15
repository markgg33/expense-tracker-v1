// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  const ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2),
          boxShadow: [
            BoxShadow(
              offset: Offset(5, 5),
            ),
          ],
        ),
        child: ListTile(
          title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
            '${dateTime.day}/${dateTime.month}/${dateTime.year}',
          ),
          trailing: Text(
            'PHP $amount',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
