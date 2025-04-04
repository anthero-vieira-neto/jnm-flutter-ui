import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@Deprecated(
  'Use variant JNMLineChart instead.',
)
/// JNM UI's line chart inside a card.
class JNMLineChartCard extends StatelessWidget {
  /// Chart's title.
  final String title;

  /// Chart's subtitle if any.
  final String? subtitle;

  /// Chart's list of data.
  final List<JNMLineChartDataSeries> dataSource;

  /// Chart's spline type.
  final JNMLineChartSplineType splineType;

  const JNMLineChartCard({
    required this.title,
    required this.dataSource,
    this.subtitle,
    this.splineType = JNMLineChartSplineType.natural,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: JNMBoxShadow.sm,
        color: JNMColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: LibraryTextStyles.interLgSemiboldNeutral,
            ),
            subtitle != null
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2.0),
                Text(
                  subtitle!,
                  style: JNMFontFamilies.inter(
                    color: const Color(
                      0xFF7A838F,
                    ), // FIXME: Not using JNMColors
                    fontSize: JNMFontSizes.sm,
                    fontWeight: JNMFontWeights.regular,
                  ),
                ),
              ],
            )
                : Container(),
            const SizedBox(height: 8.0),
            SfCartesianChart(
              margin: EdgeInsets.zero,
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                majorTickLines: const MajorTickLines(
                  color: Colors.transparent,
                ),
                axisLine: const AxisLine(
                  color: Colors.transparent,
                ),
                labelStyle: LibraryTextStyles.interXsRegularGrey600,
              ),
              plotAreaBorderColor: Colors.transparent,
              primaryYAxis: CategoryAxis(
                maximumLabelWidth: 0.0,
                axisLine: const AxisLine(
                  color: Colors.transparent,
                ),
                majorTickLines: const MajorTickLines(
                  color: Colors.transparent,
                ),
                labelStyle: const TextStyle(color: Colors.transparent),
                majorGridLines: const MajorGridLines(
                  width: 1.0,
                  // ignore: deprecated_member_use_from_same_package
                  color: JNMColors.grey100, // FIXME
                ),
              ),
              legend: const Legend(
                isVisible: false,
              ),
              tooltipBehavior: TooltipBehavior(
                color: const Color(0xFF2F2F2F), // FIXME: Not using JNMColors
                enable: true,
                builder: (data, point, series, pointIndex, seriesIndex) {
                  final chartData = data as JNMLineChartData;
                  final chartSeries =
                  series as SplineSeries<JNMLineChartData, String>;
                  return FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF2F2F2F,
                        ), // FIXME: Not using JNMColors
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 12.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: JNMFontFamilies.inter(
                                color: const Color(
                                  0xFF9F9E9E,
                                ), // FIXME: Not using JNMColors
                                fontSize: JNMFontSizes.xs,
                                fontWeight: JNMFontWeights.regular,
                              ),
                            ),
                            const SizedBox(height: 7.0),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: chartSeries.color,
                                  ),
                                  width: 10.0,
                                  height: 10.0,
                                ),
                                const SizedBox(width: 7.0),
                                Text(
                                  '${chartData.label}: ${chartData.value}',
                                  style: LibraryTextStyles.interXsRegularWhite,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              series:
              // Alterado a declaração para <CartesianSeries<...>> e aplicado .toList()
              <CartesianSeries<JNMLineChartData, String>>[
                ...dataSource.map((e) {
                  SplineType splineTypeSeries;
                  switch (splineType) {
                    case JNMLineChartSplineType.monotonic:
                      splineTypeSeries = SplineType.monotonic;
                      break;
                    case JNMLineChartSplineType.clamped:
                      splineTypeSeries = SplineType.clamped;
                      break;
                    case JNMLineChartSplineType.natural:
                    default:
                      splineTypeSeries = SplineType.natural;
                      break;
                  }
                  return SplineSeries<JNMLineChartData, String>(
                    dataSource: e.dataPoints,
                    legendIconType: LegendIconType.circle,
                    name: e.label,
                    enableTooltip: true,
                    color: e.color,
                    splineType: splineTypeSeries,
                    xValueMapper: (JNMLineChartData data, _) => data.label,
                    yValueMapper: (JNMLineChartData data, _) => data.value,
                  );
                }).toList(),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                ...dataSource.asMap().entries.map(
                      (entry) {
                    final dataPoint = entry.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16.0,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: dataPoint.color,
                                  ),
                                  height: 8.0,
                                  width: 8.0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                dataPoint.label,
                                style: LibraryTextStyles.interXsRegularGrey600,
                              ),
                            ),
                          ],
                        ),
                        entry.key < dataSource.length - 1
                            ? const SizedBox(height: 4.0)
                            : Container(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}