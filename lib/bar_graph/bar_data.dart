import 'package:expense_tracker/bar_graph/bargraph.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  List<Bargraph> barData = [];
  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<Bargraph> barDatas = [];

  void initializeBarData() {
    barDatas = [
      Bargraph(x: 0, y: sunAmount),
      Bargraph(x: 1, y: monAmount),
      Bargraph(x: 2, y: tueAmount),
      Bargraph(x: 3, y: wedAmount),
      Bargraph(x: 4, y: thurAmount),
      Bargraph(x: 5, y: friAmount),
      Bargraph(x: 6, y: satAmount),
    ];
  }
}
