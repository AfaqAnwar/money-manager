import 'package:flutter/material.dart';
import 'package:moneymanager/data/user.dart';
import 'package:moneymanager/utils/constants.dart';
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(defaultSpacing),
            child: SfCartesianChart(
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
            ),
          ),
        ));
  }

  List<incomeData> getChartData() {
    List<incomeData> chartData = [];
    Map<int, int> incomeMap = CurrentUser.getMonthlyIncomeMap;
    for (int i = 1; i < 12; i++) {
      if (incomeMap.containsKey(i)) {
        var doubleIncome = incomeMap[i]!.toDouble();
        chartData.add(incomeData(i.toDouble(), doubleIncome));
      }
    }
    return chartData;
  }
}

class incomeData {
  incomeData(this.month, this.income);
  final double month;
  final double income;
}
