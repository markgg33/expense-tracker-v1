import 'package:expense_tracker_v1/bar%20graph/individual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,

    required this.friAmount,
    required this.satAmount,
  });

  List<IndividualBar> barData = [];

  // initialize bar data

  void initializeBarData(){
    barData = [ 
      //for sunday
      IndividualBar(x: 0, y: sunAmount),
      //for monday
      IndividualBar(x: 1, y: monAmount),
      //for tuesday
      IndividualBar(x: 2, y: tueAmount),
      //for wednesday
      IndividualBar(x: 3, y: wedAmount),
      //for thursday
      IndividualBar(x: 4, y: thurAmount),
      //for friday
      IndividualBar(x: 5, y: friAmount),
      //for saturday
      IndividualBar(x: 6, y: satAmount),
    ];
  }
}
