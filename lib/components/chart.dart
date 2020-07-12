import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

List<charts.Series<TimeSeries, DateTime>> generateTimeSeries(
    List<TimeSeries> data, Duration period, Color color, int length) {
  // add elements to the start of the list if we don't have enough
  final int emptySlots = length - data.length;
  if (emptySlots > 0) {
    DateTime startDate = DateTime.now();
    if (data.length > 0) {
      startDate = data[0].time;
    }
    data = List<TimeSeries>.generate(emptySlots,
        (i) => TimeSeries(startDate.subtract(period * (emptySlots - i)), 0))
      ..addAll(data);
  }
  // only keep the last length elements
  data.skip(data.length - length);
  return [
    new charts.Series<TimeSeries, DateTime>(
      id: 'Activity',
      colorFn: (_, __) =>
          charts.Color(r: color.red, g: color.green, b: color.blue),
      domainFn: (TimeSeries percentage, _) => percentage.time,
      measureFn: (TimeSeries percentage, _) => percentage.value,
      data: data,
    )
  ];
}

class TimeSeriesBar extends StatelessWidget {
  final List<charts.Series<TimeSeries, DateTime>> seriesList;
  final bool animate;

  TimeSeriesBar(
      {@required List<TimeSeries> data,
      @required Duration period,
      @required Color color,
      @required int length,
      @required this.animate})
      : seriesList = generateTimeSeries(data, period, color, length);

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Set the default renderer to a bar renderer.
      // This can also be one of the custom renderers of the time series chart.
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      // It is recommended that default interactions be turned off if using bar
      // renderer, because the line point highlighter is the default for time
      // series chart.
      defaultInteractions: false,
      // If default interactions were removed, optionally add select nearest
      // and the domain highlighter that are typical for bar charts.
      behaviors: [charts.SelectNearest(), charts.DomainHighlighter()],
    );
  }
}

/// Sample time series data type.
class TimeSeries {
  final DateTime time;
  final int value;

  TimeSeries(this.time, this.value);
}
