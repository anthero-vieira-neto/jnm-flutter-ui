import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// [JNMDonutChartCard]'s data point class.
class JNMDonutChartData {
  /// The data point's label.
  final String label;

  /// The data point's value.
  final int value;

  /// The data point's color.
  final Color color;

  JNMDonutChartData({
    required this.label,
    required this.value,
    required this.color,
  });
}

/// JNM UI's donut chart inside a card.
class JNMDonutChartCard extends StatelessWidget {
  /// Chart's title.
  final String title;

  /// Chart's subtitle if any.
  final String? subtitle;

  /// Chart's list of data.
  final List<JNMDonutChartData> dataSource;

  const JNMDonutChartCard({
    required this.title,
    required this.dataSource,
    this.subtitle,
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
            SizedBox(
              height: 200,
              child: SfCircularChart(
                legend: Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  position: LegendPosition.bottom,
                  legendItemBuilder: (legendText, series, point, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: point.color,
                              ),
                              width: 8.0,
                              height: 8.0,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              legendText,
                              style: JNMFontFamilies.inter(
                                // ignore: deprecated_member_use_from_same_package
                                color: JNMColors.grey600, // FIXME
                                fontSize: JNMFontSizes.sm,
                                fontWeight: JNMFontWeights.regular,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                tooltipBehavior: TooltipBehavior(
                  color:
                      const Color(0xFF2F2F2F), // FIXME: Not using JNMColors
                  enable: true,
                  builder: (data, point, series, pointIndex, seriesIndex) {
                    final chartData = data as JNMDonutChartData;
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
                                      color: chartData.color,
                                    ),
                                    width: 10.0,
                                    height: 10.0,
                                  ),
                                  const SizedBox(width: 7.0),
                                  Text(
                                    '${chartData.label}: ${chartData.value}',
                                    style:
                                        LibraryTextStyles.interXsRegularWhite,
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
                series: <CircularSeries>[
                  DoughnutSeries<JNMDonutChartData, String>(
                    radius: '100%',
                    innerRadius: '70%',
                    dataSource: dataSource,
                    pointColorMapper: (JNMDonutChartData data, _) =>
                        data.color,
                    xValueMapper: (JNMDonutChartData data, _) => data.label,
                    yValueMapper: (JNMDonutChartData data, _) => data.value,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
