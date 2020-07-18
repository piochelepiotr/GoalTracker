/// Donut chart example. This is a simple pie chart with a hole in the middle.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class AchievementChart extends StatelessWidget {
  List<charts.Series> seriesList;
  final double workDone;
  final Color color;

  AchievementChart({@required this.workDone, @required this.color}) {
    final data = [
      new Work(true, workDone),
      new Work(false, 1 - workDone),
    ];

    seriesList = [
      new charts.Series<Work, bool>(
        id: 'Sales',
        domainFn: (Work work, _) => work.done,
        measureFn: (Work work, _) => work.value,
        colorFn: (Work work, _) => work.done
            ? charts.Color(
                r: 255 - color.red, g: 255 - color.green, b: 255 - color.blue)
            : charts.Color(r: color.red, g: color.green, b: color.blue),
        labelAccessorFn: (Work work, _) =>
            work.value >= 0.3 ? work.done ? "done" : "to do" : "",
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(seriesList,
        defaultInteractions: false,
        layoutConfig: charts.LayoutConfig(
            leftMarginSpec: charts.MarginSpec.fromPixel(maxPixel: 0),
            topMarginSpec: charts.MarginSpec.fromPixel(maxPixel: 0),
            rightMarginSpec: charts.MarginSpec.fromPixel(maxPixel: 0),
            bottomMarginSpec: charts.MarginSpec.fromPixel(maxPixel: 0)),
        animate: false,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 40,
            arcRendererDecorators: [
              new charts.ArcLabelDecorator(
                  labelPosition: charts.ArcLabelPosition.inside)
            ]));
  }
}

class Work {
  final bool done;
  final double value;

  Work(this.done, this.value);
}
