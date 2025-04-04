import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

/// Possible modes for date picker.
enum JNMDatePickerMode {
  /// For picking single date.
  single,

  /// For picking range date.
  range,
}

/// Displays [JNMDatePickerDialog].
Future<T?> showJNMDatePickerDialog<T>({
  required BuildContext context,
  JNMDatePickerMode mode = JNMDatePickerMode.single,
  DateTime? initialDisplayDate,
  DateTime? initialSelectedDate,
  DateTimeRange? initialSelectedRange,
  DateTime? minDate,
  DateTime? maxDate,
  String positiveButtonLabel = 'Apply',
  String negativeButtonLabel = 'Cancel',
  List<String> weekNames = const ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sat', 'Su'],
}) async {
  return JNMUiUtils.showJNMDialog<T>(
    context: context,
    builder: (context) {
      return JNMDatePickerDialog(
        mode: mode,
        initialDisplayDate: initialDisplayDate,
        initialSelectedDate: initialSelectedDate,
        initialSelectedRange: initialSelectedRange,
        minDate: minDate,
        maxDate: maxDate,
        positiveButtonLabel: positiveButtonLabel,
        negativeButtonLabel: negativeButtonLabel,
        weekNames: weekNames,
      );
    },
  );
}

/// JNM UI's Date Picker Dialog component widget.
class JNMDatePickerDialog extends StatefulWidget {
  /// The picker mode.
  final JNMDatePickerMode mode;

  /// The initial displayed date. The default value is `DateTime.now()`.
  ///
  /// Normally, for single mode, you will choose the [initialSelectedDate] and
  /// for range mode, you will choose the [initialSelectedRange.start].
  final DateTime? initialDisplayDate;

  /// The initial selected date (Used in single mode only).
  final DateTime? initialSelectedDate;

  /// The initial selected date range (Used in range mode only).
  final DateTimeRange? initialSelectedRange;

  /// The minimum date that can be selected.
  final DateTime? minDate;

  /// The maximum date that can be selected.
  final DateTime? maxDate;

  /// The positive button label.
  final String positiveButtonLabel;

  /// The negative button label.
  final String negativeButtonLabel;

  /// The week names displayed in the header.
  final List<String> weekNames;

  const JNMDatePickerDialog({
    super.key,
    this.mode = JNMDatePickerMode.single,
    this.initialDisplayDate,
    this.initialSelectedDate,
    this.initialSelectedRange,
    this.minDate,
    this.maxDate,
    this.positiveButtonLabel = 'Apply',
    this.negativeButtonLabel = 'Cancel',
    this.weekNames = const ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sat', 'Su'],
  });

  @override
  State<JNMDatePickerDialog> createState() =>
      _JNMDatePickerDialogState();
}

class _JNMDatePickerDialogState extends State<JNMDatePickerDialog> {
  /// Range start input controller.
  late TextEditingController _selectedRangeStartInputController;

  /// Range end input controller.
  late TextEditingController _selectedRangeEndInputController;

  /// Date picker controller.
  late DateRangePickerController _controller;

  /// The displayed date.
  DateTime _displayedDate = DateTime.now();

  /// The selected date for single mode.
  DateTime? _selectedDate;

  /// The selected date range for range mode.
  DateTimeRange? _selectedRange;

  /// Whether to show header widgets.
  bool _showHeader = true;

  @override
  void initState() {
    super.initState();
    _selectedRangeStartInputController = TextEditingController();
    _selectedRangeEndInputController = TextEditingController();

    _controller = DateRangePickerController()
      ..addPropertyChangedListener((propertyName) {
        if (propertyName == 'view') {
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              _showHeader = _controller.view == DateRangePickerView.month;
            });
          });
        } else if (propertyName == 'displayDate') {
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              _displayedDate = _controller.displayDate ?? DateTime.now();
            });
          });
        } else if (propertyName == 'selectedDate') {
          final formatter = DateFormat('MMM d, y');
          Future.delayed(const Duration(milliseconds: 100), () {
            _selectedRangeStartInputController.text =
                formatter.format(_controller.selectedDate!);
            setState(() {
              _selectedDate = _controller.selectedDate;
            });
          });
        } else if (propertyName == 'selectedRange') {
          final formatter = DateFormat('MMM d, y');
          Future.delayed(const Duration(milliseconds: 100), () {
            DateTime? startDate = _controller.selectedRange?.startDate;
            DateTime? endDate = _controller.selectedRange?.endDate;
            if (startDate != null) {
              _selectedRangeStartInputController.text =
                  formatter.format(startDate);
            } else {
              _selectedRangeStartInputController.text = '';
            }
            if (endDate != null) {
              _selectedRangeEndInputController.text = formatter.format(endDate);
            } else {
              _selectedRangeEndInputController.text = '';
            }
            setState(() {
              if (startDate != null && endDate != null) {
                _selectedRange = DateTimeRange(
                  start: _controller.selectedRange!.startDate!,
                  end: _controller.selectedRange!.endDate!,
                );
              } else {
                _selectedRange = null;
              }
            });
          });
        }
      });
  }

  @override
  void dispose() {
    _selectedRangeStartInputController.dispose();
    _selectedRangeEndInputController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool enableApplyButton = false;
    if (widget.mode == JNMDatePickerMode.single) {
      enableApplyButton = _selectedDate != null;
    } else {
      enableApplyButton = _selectedRange != null;
    }
    return Dialog(
      child: Container(
        width: 328.0,
        height: _showHeader ? 560.0 : 560.0 - 92.0,
        decoration: BoxDecoration(
          color: JNMColors.white,
          borderRadius: BorderRadius.circular(JNMBorderRadius.sm),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 24.0,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        JNMTertiaryNeutralButton.iconOnly(
                          iconAssetName: JNMIcons.chevron_left,
                          onPressed: _handlePressedPreviousMonthButton,
                          height: JNMButtonHeights.sm,
                        ),
                        Expanded(
                          child: Material(
                            color: JNMColors.white,
                            child: InkWell(
                              onTap: () => _handlePressedTitle(context),
                              child: SizedBox(
                                height: 36.0,
                                child: Center(
                                  child: Text(
                                    DateFormat('MMMM y').format(_displayedDate),
                                    style: LibraryTextStyles.interMdBoldNeutral,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        JNMTertiaryNeutralButton.iconOnly(
                          iconAssetName: JNMIcons.chevron_right,
                          onPressed: _handlePressedNextMonthButton,
                          height: JNMButtonHeights.sm,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    _showHeader
                        ? Column(
                            children: [
                              _buildInputFields(),
                              const SizedBox(height: 12.0),
                              SizedBox(
                                height: 40.0,
                                child: Row(
                                  children: [
                                    ...widget.weekNames.map(
                                      (e) => Expanded(
                                        child: Text(
                                          e,
                                          textAlign: TextAlign.center,
                                          style: LibraryTextStyles
                                              .interSmMediumNeutral,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SfDateRangePicker(
                      controller: _controller,
                      minDate: widget.minDate,
                      maxDate: widget.maxDate,
                      headerHeight: 0.0,
                      initialDisplayDate: widget.initialDisplayDate,
                      initialSelectedDate: widget.initialSelectedDate,
                      initialSelectedRange: widget.initialSelectedRange != null
                          ? PickerDateRange(
                              widget.initialSelectedRange!.start,
                              widget.initialSelectedRange!.end,
                            )
                          : null,
                      selectionMode: widget.mode == JNMDatePickerMode.single
                          ? DateRangePickerSelectionMode.single
                          : DateRangePickerSelectionMode.range,
                      // todayHighlightColor: JNMColors.warning200,
                      monthViewSettings: DateRangePickerMonthViewSettings(
                        viewHeaderHeight: 0.0,
                        showTrailingAndLeadingDates: true,
                        // numberOfWeeksInView: 5,
                        firstDayOfWeek: 1,
                        specialDates: [
                          DateTime(2023, 2, 22),
                        ],
                      ),
                      monthCellStyle: DateRangePickerMonthCellStyle(
                        todayCellDecoration: const BoxDecoration(
                          color: JNMColors.warning200,
                          shape: BoxShape.circle,
                        ),
                        textStyle: LibraryTextStyles.interSmMediumNeutral,
                        leadingDatesTextStyle:
                            LibraryTextStyles.interSmMediumNeutral300,
                        trailingDatesTextStyle:
                            LibraryTextStyles.interSmMediumNeutral300,
                        disabledDatesTextStyle:
                            LibraryTextStyles.interSmMediumNeutral100,
                        todayTextStyle: LibraryTextStyles.interSmMediumNeutral,
                      ),
                      rangeTextStyle: LibraryTextStyles.interSmMediumNeutral,
                      selectionTextStyle: LibraryTextStyles.interSmMediumWhite,
                      selectionColor: JNMColors.primary,
                      startRangeSelectionColor: JNMColors.primary,
                      endRangeSelectionColor: JNMColors.primary,
                      rangeSelectionColor: JNMColors.neutral50,
                    ),
                  ],
                ),
              ),
              const JNMDivider(height: 0.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: JNMOutlineButton.text(
                        text: widget.negativeButtonLabel,
                        onPressed: _handlePressedCancelButton,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: JNMPrimaryButton.text(
                        text: widget.positiveButtonLabel,
                        onPressed: enableApplyButton
                            ? _handlePressedApplyButton
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build input fields widget.
  Widget _buildInputFields() {
    if (widget.mode == JNMDatePickerMode.single) {
      return Row(
        children: [
          Expanded(
            child: JNMTextInputField(
              controller: _selectedRangeStartInputController,
              label: null,
              readOnly: true,
              mouseCursor: SystemMouseCursors.basic,
              size: JNMTextInputFieldSize.sm,
            ),
          ),
          const SizedBox(width: 12.0),
          JNMOutlineButton.text(
            text: 'Today',
            onPressed: _handlePressedTodayButton,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: JNMTextInputField(
              controller: _selectedRangeStartInputController,
              label: null,
              readOnly: true,
              mouseCursor: SystemMouseCursors.basic,
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            '-',
            style: LibraryTextStyles.interMdRegularNeutral300,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: JNMTextInputField(
              controller: _selectedRangeEndInputController,
              label: null,
              readOnly: true,
              mouseCursor: SystemMouseCursors.basic,
            ),
          ),
        ],
      );
    }
  }

  /// Handle pressing previous month button.
  void _handlePressedPreviousMonthButton() {
    if (_controller.backward != null) {
      _controller.backward!();
    }
  }

  /// Handle pressing next month button.
  void _handlePressedNextMonthButton() {
    if (_controller.forward != null) {
      _controller.forward!();
    }
  }

  /// Handle pressing today button.
  void _handlePressedTodayButton() {
    _controller.displayDate = DateTime.now();
  }

  /// Handle pressing cancel button.
  void _handlePressedCancelButton() {
    Navigator.of(context).pop();
  }

  /// Handle pressing apply button.
  void _handlePressedApplyButton() {
    if (widget.mode == JNMDatePickerMode.single) {
      Navigator.of(context).pop(_selectedDate);
    } else {
      Navigator.of(context).pop(_selectedRange);
    }
  }

  /// Handle pressing title.
  void _handlePressedTitle(BuildContext context) {
    if (_controller.view == DateRangePickerView.decade) {
      _controller.view = DateRangePickerView.month;
    } else {
      _controller.view = DateRangePickerView.decade;
    }
  }
}
