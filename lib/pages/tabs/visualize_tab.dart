import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

// Main Page
class VisualizePage extends StatefulWidget {
  const VisualizePage({Key? key}) : super(key: key);

  @override
  State<VisualizePage> createState() => VisualizePageState();
}

class VisualizePageState extends State<VisualizePage> {
  // Initially checks for survey completion to ensure proper data is present.

  late List<incomeData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(220, 0, 0, 0), //AppStyle.bg_color,
          elevation: 0.0,

          title: Text(
            "Welcome to the Investment Visualizer!",
            selectionColor: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        body: SfCartesianChart(
          title: ChartTitle(
              text: 'Investments',
              textStyle: TextStyle(fontSize: 20)), //SIZE OF FONT
          legend: Legend(isVisible: true),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            LineSeries<incomeData, double>(
                name: 'Amount Invested',
                dataSource: _chartData,
                xValueMapper: (incomeData month, _) => month.month,
                yValueMapper: (incomeData month, _) => month.income,
                dataLabelSettings: DataLabelSettings(isVisible: true),
                enableTooltip: true),
          ],
          primaryXAxis:
              NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
          primaryYAxis: NumericAxis(
              numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
        ));
  }

  List<incomeData> getChartData() {
    final List<incomeData> chartData = [
      incomeData(1, 300), //GET VALUES IN SECOND PART FROM FIREBASE
      incomeData(2, 400),
      incomeData(3, 500),
      incomeData(4, 600),
      incomeData(5, 700),
      incomeData(6, 800),
      incomeData(7, 900),
      incomeData(8, 600),
      incomeData(9, 822),
      incomeData(10, 566),
      incomeData(11, 455),
      incomeData(12, 500)
    ];
    return chartData;
  }
}

class incomeData {
  incomeData(this.month, this.income);
  final double month;
  final double income;
}
