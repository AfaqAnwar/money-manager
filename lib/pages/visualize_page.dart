import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/model/chart_data.dart';
import 'package:moneymanager/pages/survey.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moneymanager/style/app_style.dart';
import 'package:moneymanager/user.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:moneymanager/model/chart_data.dart';
import 'package:moneymanager/style/app_style.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Main Page
class VisualizePage extends StatefulWidget {
  const VisualizePage({Key? key}) : super(key: key);

  @override
  State<VisualizePage> createState() => VisualizePageState();
}

class VisualizePageState extends State<VisualizePage> {
  // Initially checks for survey completion to ensure proper data is present.

  late List<ChartData> data;

  @override
  void initState() {
    super.initState();
    data = [
      ChartData(17, 21500),
      ChartData(18, 22684),
      ChartData(19, 21643),
      ChartData(20, 22997),
      ChartData(21, 22883),
      ChartData(22, 22635),
      ChartData(23, 21800),
      ChartData(24, 23500),
      ChartData(25, 21354),
      ChartData(26, 22354)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(220, 0, 0, 0), //AppStyle.bg_color,
        elevation: 0.0,

        title: Text(
          "Welcome to Savings!",
          selectionColor: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Savings Per Week',
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://as1.ftcdn.net/v2/jpg/01/83/27/62/1000_F_183276280_zZi6bjMJPMbfHc5aqENjaU4dZSkOVdzK.jpg'),
            radius: 36.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text("Amount Saved",
              style:
                  TextStyle(color: Color.fromARGB(220, 0, 0, 0), fontSize: 24)),
          Center(
            child: SfCartesianChart(
                margin: EdgeInsets.all(0),
                borderWidth: 0,
                borderColor: Colors.transparent,
                plotAreaBorderWidth: 0,
                primaryXAxis: NumericAxis(
                    minimum:
                        17, //min value from list/data so maybe make this JANUARY (1)
                    maximum:
                        26, //max this from data too so make this DECEMBER (12)
                    isVisible: false,
                    interval: 1,
                    borderWidth: 0,
                    borderColor: Colors.transparent),
                primaryYAxis: NumericAxis(
                    minimum: 19000, //least money a teen could possible have?
                    maximum:
                        24000, //what's the most money a teen could possibly have?
                    interval: 1000,
                    isVisible: true,
                    borderWidth: 0,
                    borderColor: Colors.transparent),
                series: <ChartSeries<ChartData, int>>[
                  SplineAreaSeries(
                    dataSource: data,
                    xValueMapper: (ChartData data, _) => data.day,
                    yValueMapper: (ChartData data, _) => data.price,
                    splineType: SplineType.natural,
                    gradient: LinearGradient(
                      colors: [
                        AppStyle.spline_color,
                        AppStyle.bg_color.withAlpha(
                            150) //spline color is in the styles folder...maybe change to spine_color!!!!!
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  SplineSeries(
                      dataSource: data,
                      color: AppStyle.accent_color,
                      width: 4,
                      markerSettings: MarkerSettings(
                          color: Colors.white, //this is the color OF the circle
                          borderWidth: 2,
                          shape: DataMarkerType.circle,
                          isVisible: true,
                          borderColor: Color.fromARGB(255, 0, 159,
                              22)), //this is the color AROUND the circle
                      xValueMapper: (ChartData data, _) => data.day,
                      yValueMapper: (ChartData data, _) => data.price)
                ]),
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    side: BorderSide(
                      color: AppStyle.accent_color,
                    )),
                icon: Icon(Icons.currency_exchange, color: Colors.black),
                label: Text(
                  "input amount here",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
              /*TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    backgroundColor: AppStyle.accent_color,),
                  icon: Icon(Icons.download, color: Colors.white),
                  label: Text("Please Enter Amount",
                      style: TextStyle(color: Colors.black, fontSize: 18))),*/
            ],
          )
        ],
      ),
    );
  }
}
