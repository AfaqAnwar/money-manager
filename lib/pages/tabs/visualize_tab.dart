import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:moneymanager/data/user.dart';
import 'package:moneymanager/utils/colors.dart';
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

  late List<IncomeData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late List<ExpenseData> _expenseData;

  @override
  void initState() {
    _chartData = getChartData();
    _expenseData = getChartExpenseData();
    print(_expenseData);
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LoopPageView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(defaultSpacing),
                    child: SfCartesianChart(
                      title: ChartTitle(
                          text: 'Savings Throughout This Year',
                          textStyle:
                              const TextStyle(fontSize: 20)), //SIZE OF FONT
                      legend: Legend(isVisible: true),
                      tooltipBehavior: _tooltipBehavior,
                      series: <ChartSeries>[
                        LineSeries<IncomeData, double>(
                            color: AppColor.customDarkGreen,
                            name: 'Amount of Income',
                            dataSource: _chartData,
                            xValueMapper: (IncomeData month, _) => month.month,
                            yValueMapper: (IncomeData month, _) => month.income,
                            dataLabelSettings: DataLabelSettings(
                                isVisible: false,
                                color: AppColor.customDarkGreen),
                            enableTooltip: true),
                      ],
                      primaryXAxis: NumericAxis(
                          edgeLabelPlacement: EdgeLabelPlacement.shift),
                      primaryYAxis: NumericAxis(
                          numberFormat:
                              NumberFormat.simpleCurrency(decimalDigits: 0)),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(defaultSpacing),
                    child: SfCartesianChart(
                      title: ChartTitle(
                          text: 'Expenses Throughout This Year',
                          textStyle:
                              const TextStyle(fontSize: 20)), //SIZE OF FONT
                      legend: Legend(isVisible: true),
                      tooltipBehavior: _tooltipBehavior,
                      series: <ChartSeries>[
                        LineSeries<ExpenseData, double>(
                            color: AppColor.customDarkGreen,
                            name: 'Amount of Expense',
                            dataSource: _expenseData,
                            xValueMapper: (ExpenseData data, _) =>
                                data.expenseMonth,
                            yValueMapper: (ExpenseData data, _) =>
                                data.expenseAmount,
                            dataLabelSettings: DataLabelSettings(
                                isVisible: false,
                                color: AppColor.customDarkGreen),
                            enableTooltip: true),
                      ],
                      primaryXAxis: NumericAxis(
                          edgeLabelPlacement: EdgeLabelPlacement.shift),
                      primaryYAxis: NumericAxis(
                          numberFormat:
                              NumberFormat.simpleCurrency(decimalDigits: 0)),
                    ),
                  );
                }
              }),
        ));
  }

  List<IncomeData> getChartData() {
    List<IncomeData> chartData = [];
    Map<int, double> incomeMap = CurrentUser.getMonthlyIncomeMap;
    for (int i = 1; i <= 12; i++) {
      if (incomeMap.containsKey(i)) {
        chartData.add(IncomeData(i.toDouble(), incomeMap[i]!));
      }
    }
    return chartData;
  }
}

List<ExpenseData> getChartExpenseData() {
  List<ExpenseData> chartExpenseData = [];
  Map<int, double> expenseMap = CurrentUser.getMonthlyExpenseMap;
  for (int i = 1; i <= 12; i++) {
    if (expenseMap.containsKey(i)) {
      chartExpenseData.add(ExpenseData(i.toDouble(), expenseMap[i]!));
    }
  }
  return chartExpenseData;
}

class IncomeData {
  IncomeData(this.month, this.income);
  final double month;
  final double income;
}

class ExpenseData {
  ExpenseData(this.expenseMonth, this.expenseAmount);
  final double expenseMonth;
  final double expenseAmount;
}
