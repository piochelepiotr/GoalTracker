/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../model/habit.dart';

List<charts.Series<TimeSeriesPercentage, DateTime>> generateTimeSeries(
    List<HabitResult> habitHistory, Duration period, Color color) {
  List<TimeSeriesPercentage> percentages = List<TimeSeriesPercentage>();
  int total = 0;
  int ok = 0;
  final int length = 15;

  final int emptySlots = length - habitHistory.length;
  if (emptySlots > 0) {
    print("not engough data");
    DateTime startDate = DateTime.now();
    if (habitHistory.length > 0) {
      startDate = habitHistory[0].start;
    }

    for (int i = 0; i < emptySlots; i++) {
      percentages.add(TimeSeriesPercentage(
          startDate.subtract(period * (emptySlots - i)), 0));
    }
  }
  for (final result in habitHistory) {
    total++;
    if (result.objective == result.achieved) {
      ok++;
    }
    if (habitHistory.length - total < length) {
      percentages
          .add(TimeSeriesPercentage(result.start, (100 * ok / total).round()));
    }
  }
  print("percentages");
  for (final p in percentages) {
    print(p.percentage);
    print(p.time);
  }
  return [
    new charts.Series<TimeSeriesPercentage, DateTime>(
      id: 'Sales',
      colorFn: (_, __) =>
          charts.Color(r: color.red, g: color.green, b: color.blue),
      domainFn: (TimeSeriesPercentage percentage, _) => percentage.time,
      measureFn: (TimeSeriesPercentage percentage, _) => percentage.percentage,
      data: percentages,
    )
  ];
}

class TimeSeriesBar extends StatelessWidget {
  final List<charts.Series<TimeSeriesPercentage, DateTime>> seriesList;

  TimeSeriesBar(List<HabitResult> habitHistory, Duration period, Color color)
      : seriesList = generateTimeSeries(habitHistory, period, color);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 200,
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: charts.TimeSeriesChart(
              seriesList,
              animate: true,
              // Set the default renderer to a bar renderer.
              // This can also be one of the custom renderers of the time series chart.
              defaultRenderer: new charts.BarRendererConfig<DateTime>(),
              // It is recommended that default interactions be turned off if using bar
              // renderer, because the line point highlighter is the default for time
              // series chart.
              defaultInteractions: false,
              // If default interactions were removed, optionally add select nearest
              // and the domain highlighter that are typical for bar charts.
              behaviors: [
                new charts.SelectNearest(),
                new charts.DomainHighlighter()
              ],
            )));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesPercentage, DateTime>>
      _createSampleData() {
    final data = [
      new TimeSeriesPercentage(new DateTime(2017, 9, 1), 5),
      new TimeSeriesPercentage(new DateTime(2017, 9, 2), 5),
      new TimeSeriesPercentage(new DateTime(2017, 9, 3), 25),
      new TimeSeriesPercentage(new DateTime(2017, 9, 4), 100),
      new TimeSeriesPercentage(new DateTime(2017, 9, 5), 75),
      new TimeSeriesPercentage(new DateTime(2017, 9, 6), 88),
      new TimeSeriesPercentage(new DateTime(2017, 9, 7), 65),
      new TimeSeriesPercentage(new DateTime(2017, 9, 8), 91),
      new TimeSeriesPercentage(new DateTime(2017, 9, 9), 100),
      new TimeSeriesPercentage(new DateTime(2017, 9, 10), 111),
      new TimeSeriesPercentage(new DateTime(2017, 9, 11), 90),
      new TimeSeriesPercentage(new DateTime(2017, 9, 12), 50),
      new TimeSeriesPercentage(new DateTime(2017, 9, 13), 40),
      new TimeSeriesPercentage(new DateTime(2017, 9, 14), 30),
      new TimeSeriesPercentage(new DateTime(2017, 9, 15), 40),
      new TimeSeriesPercentage(new DateTime(2017, 9, 16), 50),
      new TimeSeriesPercentage(new DateTime(2017, 9, 17), 30),
      new TimeSeriesPercentage(new DateTime(2017, 9, 18), 35),
      new TimeSeriesPercentage(new DateTime(2017, 9, 19), 40),
      new TimeSeriesPercentage(new DateTime(2017, 9, 20), 32),
      new TimeSeriesPercentage(new DateTime(2017, 9, 21), 31),
    ];

    return [
      new charts.Series<TimeSeriesPercentage, DateTime>(
        id: 'Percentages',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesPercentage percentage, _) => percentage.time,
        measureFn: (TimeSeriesPercentage percentage, _) =>
            percentage.percentage,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesPercentage {
  final DateTime time;
  final int percentage;

  TimeSeriesPercentage(this.time, this.percentage);
}
