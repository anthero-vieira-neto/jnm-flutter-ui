import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

@Deprecated(
  'Use variant JNMStackedHorizontalBarChart instead.',
)

/// JNM UI's stacked horizontal bar chart inside a card.
class JNMStackedHorizontalBarChartCard extends StatelessWidget {
  /// Chart's title.
  final String title;

  /// Chart's subtitle if any.
  final String? subtitle;

  /// Chart's list of data.
  final List<JNMStackedHorizontalBarChartData> dataSource;

  /// String builder for legend value. If null, raw value will be used.
  final String Function(JNMStackedHorizontalBarChartData data)?
      legendValueBuilder;

  /// Chart's tooltip title. If null [title] will be used.
  final String? tooltipTitle;

  const JNMStackedHorizontalBarChartCard({
    required this.title,
    required this.dataSource,
    this.subtitle,
    this.legendValueBuilder,
    this.tooltipTitle,
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
            const SizedBox(height: 48.0),
            Column(
              children: [
                SizedBox(
                  height: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...dataSource.map(
                          (dataPoint) => Expanded(
                            flex: dataPoint.value,
                            child: JustTheTooltip(
                              backgroundColor: const Color(
                                0xFF2F2F2F,
                              ), // FIXME: Not using JNMColors
                              preferredDirection: AxisDirection.up,
                              tailLength: 8.0,
                              tailBaseWidth: 16.0,
                              content: FittedBox(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tooltipTitle ?? title,
                                          style: JNMFontFamilies.inter(
                                            color: const Color(
                                              0xFF9F9E9E,
                                            ), // FIXME
                                            fontSize: JNMFontSizes.xs,
                                            fontWeight:
                                                JNMFontWeights.regular,
                                          ),
                                        ),
                                        const SizedBox(height: 7.0),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: dataPoint.color,
                                              ),
                                              width: 10.0,
                                              height: 10.0,
                                            ),
                                            const SizedBox(width: 7.0),
                                            Text(
                                              '${dataPoint.label}: ${legendValueBuilder != null ? legendValueBuilder!(dataPoint) : dataPoint.value}', // ignore: lines_longer_than_80_chars
                                              style: LibraryTextStyles
                                                  .interXsRegularWhite,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              child: Container(
                                color: dataPoint.color,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
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
                                  height: 20.0,
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
                                  child: RichText(
                                    text: TextSpan(
                                      text: '${dataPoint.label}: ',
                                      style: LibraryTextStyles
                                          .interSmSemiboldGrey600,
                                      children: [
                                        TextSpan(
                                          text: legendValueBuilder != null
                                              ? legendValueBuilder!(dataPoint)
                                              : '${dataPoint.value}',
                                          style: LibraryTextStyles
                                              .interSmRegularGrey600,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            entry.key < dataSource.length - 1
                                ? const SizedBox(height: 8.0)
                                : Container(),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
