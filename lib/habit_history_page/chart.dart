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
  return [
    new charts.Series<TimeSeriesPercentage, DateTime>(
      id: 'Activity',
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
}

/// Sample time series data type.
class TimeSeriesPercentage {
  final DateTime time;
  final int percentage;

  TimeSeriesPercentage(this.time, this.percentage);
}
