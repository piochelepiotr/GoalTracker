import '../components/chart.dart';
import '../model/goal.dart';

TimeSeriesBar activityGraph(Goal goal) {
  DateTime startDate = DateTime.now();
  Duration period = Duration(days: 1);
  int length = 7;
  // List<TimeSeries> data = List<TimeSeries>.generate(length, (i) => TimeSeries(startDate.subtract(period * (length - i)), i));
  return TimeSeriesBar(
      data: goal.activity.getTimeSeries(),
      period: period,
      color: goal.color,
      length: length,
      animate: false);
}
