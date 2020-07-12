import 'package:flutter/material.dart';

import '../model/habit.dart';
import '../components/chart.dart';

List<TimeSeries> habitHistoryTimeSeries(List<HabitResult> habitHistory) {
  List<TimeSeries> percentages = List<TimeSeries>();
  int total = 0;
  int ok = 0;

  for (final result in habitHistory) {
    total++;
    if (result.objective == result.achieved) {
      ok++;
    }
    percentages.add(TimeSeries(result.start, (100 * ok / total).round()));
  }
  return percentages;
}

TimeSeriesBar habitHistoryGraph(
    List<HabitResult> habitHistory, Duration period, Color color) {
  List<TimeSeries> data = habitHistoryTimeSeries(habitHistory);
  return TimeSeriesBar(
      data: data, period: period, color: color, length: 15, animate: true);
}
