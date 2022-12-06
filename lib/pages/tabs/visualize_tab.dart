import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:moneymanager/data/user.dart';
import 'package:moneymanager/utils/colors.dart';
import 'package:moneymanager/utils/constants.dart';
import 'package:moneymanager/widgets/future_calculator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:xen_popup_card/xen_card.dart';

// Main Page
class VisualizePage extends StatefulWidget {
  const VisualizePage({Key? key}) : super(key: key);

  @override
  State<VisualizePage> createState() => VisualizePageState();
}

class VisualizePageState extends State<VisualizePage> {
  late List<IncomeData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late List<ExpenseData> _expenseData;

  @override
  void initState() {
    _chartData = getChartData();
    _expenseData = getChartExpenseData();
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
                  return Column(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(defaultSpacing),
                        child: SfCartesianChart(
                          title: ChartTitle(
                              text: 'Savings During This Year',
                              textStyle: GoogleFonts.bebasNeue(
                                  fontSize: 28,
                                  color: AppColor
                                      .customLightGreen)), //SIZE OF FONT
                          legend: Legend(isVisible: true),
                          tooltipBehavior: _tooltipBehavior,
                          series: <ChartSeries>[
                            LineSeries<IncomeData, double>(
                                color: AppColor.customDarkGreen,
                                name: 'Income',
                                dataSource: _chartData,
                                xValueMapper: (IncomeData month, _) =>
                                    month.month,
                                yValueMapper: (IncomeData month, _) =>
                                    month.income,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: false,
                                    color: AppColor.customDarkGreen),
                                enableTooltip: true),
                          ],
                          primaryXAxis: NumericAxis(
                              edgeLabelPlacement: EdgeLabelPlacement.shift),
                          primaryYAxis: NumericAxis(
                              numberFormat: NumberFormat.simpleCurrency(
                                  decimalDigits: 0)),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (builder) => XenPopupCard(
                                  appBar: null,
                                  body: buildFutureCalculator(context),
                                  gutter: null,
                                ));
                      },
                      splashRadius: 75,
                      iconSize: 50,
                      color: AppColor.customDarkGreen,
                      icon: Image.asset('assets/icons/Calculator.png'),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ]);
                } else {
                  return Column(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(defaultSpacing),
                        child: SfCartesianChart(
                          title: ChartTitle(
                              text: "Expenses During This Year",
                              textStyle: GoogleFonts.bebasNeue(
                                  fontSize: 28,
                                  color: AppColor.customLightGreen)),
                          legend: Legend(isVisible: true),
                          tooltipBehavior: _tooltipBehavior,
                          series: <ChartSeries>[
                            LineSeries<ExpenseData, double>(
                                color: AppColor.customDarkGreen,
                                name: 'Expense',
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
                              numberFormat: NumberFormat.simpleCurrency(
                                  decimalDigits: 0)),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 50,
                      color: AppColor.customDarkGreen,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (builder) => XenPopupCard(
                                  appBar: null,
                                  body: buildFutureCalculator(context),
                                  gutter: null,
                                ));
                      },
                      icon: Image.asset('assets/icons/Calculator.png'),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ]);
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
