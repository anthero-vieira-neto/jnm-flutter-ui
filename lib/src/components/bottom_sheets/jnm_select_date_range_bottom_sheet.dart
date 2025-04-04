import 'package:jnm_ui/jnm_ui.dart';
import 'package:jnm_ui/src/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum JNMSelectDateRangeBottomSheetOption {
  allTime,
  today,
  oneWeek,
  oneMonth,
  threeMonths,
  fourMonths,
  oneYear,
  lastYear,
  selectYear,
  selectDateRange,
}

void showJNMSelectDateRangeBottomSheet({
  required BuildContext context,
  required VoidCallback onPressedClose,
  required VoidCallback onPressedReset,
  required final void Function(
    DateTimeRange?,
    JNMSelectDateRangeBottomSheetOption?,
  ) onPressedActivate,
  JNMSelectDateRangeBottomSheetOption? initialOption =
      JNMSelectDateRangeBottomSheetOption.allTime,
  int? selectedYear,
  DateTimeRange? selectedDateRange,
  int minYear = 10,
  int maxYear = 10,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: const Color.fromRGBO(0, 0, 0, 0.35),
    builder: (BuildContext contextLocal) {
      return JNMSelectDateRangeBottomSheet(
        onPressedClose: onPressedClose,
        onPressedReset: onPressedReset,
        onPressedActivate: onPressedActivate,
        minYear: minYear,
        maxYear: maxYear,
        initialOption: initialOption,
        selectedYear: selectedYear,
        selectedDateRange: selectedDateRange,
      );
    },
  );
}

class JNMSelectDateRangeBottomSheet extends StatefulWidget {
  /// Click handler for back button.
  final VoidCallback onPressedClose;
  final VoidCallback onPressedReset;
  final void Function(DateTimeRange?, JNMSelectDateRangeBottomSheetOption?)
      onPressedActivate;
  final int minYear;
  final int maxYear;
  final JNMSelectDateRangeBottomSheetOption? initialOption;
  final int? selectedYear;
  final DateTimeRange? selectedDateRange;
  const JNMSelectDateRangeBottomSheet({
    required this.onPressedClose,
    required this.onPressedReset,
    required this.onPressedActivate,
    required this.minYear,
    required this.maxYear,
    this.initialOption = JNMSelectDateRangeBottomSheetOption.allTime,
    this.selectedYear,
    this.selectedDateRange,
    super.key,
  });

  @override
  State<JNMSelectDateRangeBottomSheet> createState() =>
      _DateRangeBottomSheetState();
}

class _DateRangeBottomSheetState
    extends State<JNMSelectDateRangeBottomSheet> {
  JNMSelectDateRangeBottomSheetOption? _selectedOption;
  DateTimeRange? dateRanges;

  final dateTimeNow = DateTime.now();
  final dateTextCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    _selectedOption = widget.initialOption;
    // initial value for radio button
    _setFromRadioFilterDateRange(widget.initialOption!);

    // initial value textfield date picker
    dateTextCtrl.text = widget.selectedDateRange != null
        ? _setTitleTextFieldDateRange(widget.selectedDateRange!)
        : '';

    // initial value for dropdown years
    if (widget.initialOption ==
        JNMSelectDateRangeBottomSheetOption.selectYear) {
      assert(
        widget.selectedYear != null,
        'selectedYear should not be null when option is selectYear',
      );
      dateRanges = _setDateTimeRange(
        DateTime(widget.selectedYear!),
        DateTime(widget.selectedYear!, 12, 31),
      );
    }

    // initial value for date range picker
    if (widget.initialOption ==
        JNMSelectDateRangeBottomSheetOption.selectDateRange) {
      assert(
        widget.selectedDateRange != null,
        'selectedDateRange should not be null when option is selectDateRange',
      );
      dateRanges = widget.selectedDateRange!;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool showSelectYearInput =
        _selectedOption == JNMSelectDateRangeBottomSheetOption.selectYear;
    bool showSelectDateRangeInput = _selectedOption ==
        JNMSelectDateRangeBottomSheetOption.selectDateRange;

    return JNMBottomSheet(
      title: 'Pilih Tanggal',
      // initialChildSize: 0.5,
      maxChildSize: 0.7,
      initialChildSize: 0.7,
      onPressedClose: widget.onPressedClose,
      children: [
        Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                JNMRadioButton(
                  size: JNMRadioButtonSize.sm,
                  value: JNMSelectDateRangeBottomSheetOption.allTime,
                  title: 'All Time',
                  groupValue: _selectedOption,
                  onChanged: _handleChangedOption,
                ),
                const SizedBox(height: 12),
                JNMRadioButton(
                  size: JNMRadioButtonSize.sm,
                  value: JNMSelectDateRangeBottomSheetOption.today,
                  title: 'Hari ini',
                  groupValue: _selectedOption,
                  onChanged: _handleChangedOption,
                ),
                const SizedBox(height: 12),
                JNMRadioButton(
                  size: JNMRadioButtonSize.sm,
                  value: JNMSelectDateRangeBottomSheetOption.oneWeek,
                  title: '1 Minggu Terakhir',
                  groupValue: _selectedOption,
                  onChanged: _handleChangedOption,
                ),
                const SizedBox(height: 12),
                JNMRadioButton(
                  size: JNMRadioButtonSize.sm,
                  value: JNMSelectDateRangeBottomSheetOption.oneMonth,
                  title: '1 Bulan Terakhir',
                  groupValue: _selectedOption,
                  onChanged: _handleChangedOption,
                ),
                const SizedBox(height: 12),
                JNMRadioButton(
                  size: JNMRadioButtonSize.sm,
                  value: JNMSelectDateRangeBottomSheetOption.threeMonths,
                  title: '3 Bulan Terakhir',
                  groupValue: _selectedOption,
                  onChanged: _handleChangedOption,
                ),
                const SizedBox(height: 12),
                JNMRadioButton(
                  size: JNMRadioButtonSize.sm,
                  value: JNMSelectDateRangeBottomSheetOption.fourMonths,
                  title: '4 Bulan Terakhir',
                  groupValue: _selectedOption,
                  onChanged: _handleChangedOption,
                ),
                const SizedBox(height: 12),
                JNMRadioButton(
                  size: JNMRadioButtonSize.sm,
                  value: JNMSelectDateRangeBottomSheetOption.oneYear,
                  title: '1 Tahun Terakhir',
                  groupValue: _selectedOption,
                  onChanged: _handleChangedOption,
                ),
                const SizedBox(height: 12),
                JNMRadioButton(
                  size: JNMRadioButtonSize.sm,
                  value: JNMSelectDateRangeBottomSheetOption.lastYear,
                  title: 'Tahun Lalu',
                  groupValue: _selectedOption,
                  onChanged: _handleChangedOption,
                ),
                const JNMDivider(height: 24.0),
                JNMRadioButton(
                  size: JNMRadioButtonSize.sm,
                  value: JNMSelectDateRangeBottomSheetOption.selectYear,
                  title: 'Pilih Tahun Lainnya',
                  groupValue: _selectedOption,
                  onChanged: _handleChangedOption,
                ),
                const SizedBox(height: 12),
                showSelectYearInput
                    ? _buildChooseAnotherYears(
                        context,
                        widget.minYear,
                        widget.maxYear,
                      )
                    : Container(),
                JNMRadioButton(
                  size: JNMRadioButtonSize.sm,
                  value:
                      JNMSelectDateRangeBottomSheetOption.selectDateRange,
                  title: 'Pilih Tanggal Sendiri',
                  groupValue: _selectedOption,
                  onChanged: _handleChangedOption,
                ),
                showSelectDateRangeInput
                    ? _buildSelectDateRange(context)
                    : Container(),
                const SizedBox(height: 36),
                Row(
                  children: [
                    Expanded(
                      child: JNMOutlineButton.text(
                        text: 'Reset',
                        onPressed: widget.onPressedReset,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: JNMPrimaryButton.text(
                        text: 'Konfirmasi',
                        onPressed: dateRanges != null
                            ? () {
                                widget.onPressedActivate(
                                  dateRanges,
                                  _selectedOption,
                                );
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

// Set value for dropdown select date range picker
  Widget _buildSelectDateRange(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tentukan periode maks. setahun ke depan atau belakang dari tanggal pilihanmu', // ignore: lines_longer_than_80_chars
            style: LibraryTextStyles.interXsRegularNeutral400,
          ),
          const SizedBox(height: 12.0),
          JNMTextInputField(
            label: null,
            prefixIconAssetName: JNMIcons.calendar,
            controller: dateTextCtrl,
            hintText: 'DD/MM/YYYY',
            onTapSuffix: null,
            errorText: null,
            enabled: true,
            readOnly: true,
            onTap: () {
              showJNMDatePickerDialog(
                initialSelectedRange: dateRanges,
                context: context,
                mode: JNMDatePickerMode.range,
                maxDate: _setAddDate(360),
                minDate: _setSubTractDate(360),
              ).then(
                (pickedDate) {
                  FocusManager.instance.primaryFocus?.unfocus();

                  if (pickedDate == null) {
                    return;
                  }

                  setState(() {
                    dateTextCtrl.text = _setTitleTextFieldDateRange(pickedDate);
                  });
                  dateRanges = pickedDate;
                },
              );
            },
          ),
          const SizedBox(height: 12.0),
        ],
      ),
    );
  }

  // Set title textfield date range
  String _setTitleTextFieldDateRange(DateTimeRange selectDateTimeRange) {
    List<String> dates = selectDateTimeRange.toString().split(' - ');
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    String formattedStartDate = dateFormat.format(DateTime.parse(dates[0]));
    String formattedEndDate = dateFormat.format(DateTime.parse(dates[1]));

    return '$formattedStartDate - $formattedEndDate';
  }

  // Set data to type DateTimeRange
  DateTimeRange _setDateTimeRange(DateTime start, DateTime end) {
    DateTimeRange dateTimeRange = DateTimeRange(
      start: start,
      end: end,
    );
    return dateTimeRange;
  }

  // Ignore value if selected selectYear and selectDateRange
  void _handleChangedOption(JNMSelectDateRangeBottomSheetOption value) {
    setState(() {
      _selectedOption = value;

      _setFromRadioFilterDateRange(value);
    });
  }

  // Set datetime for today
  DateTime _setForToday() {
    DateTime startOfToday = DateTime(
      dateTimeNow.year,
      dateTimeNow.month,
      dateTimeNow.day,
      0,
      0,
      0,
      0,
    );
    return startOfToday;
  }

  // Set datetime based subtract (-)
  DateTime _setSubTractDate(int? subTractDate) {
    DateTime subTractedDate =
        dateTimeNow.subtract(Duration(days: subTractDate!));
    return subTractedDate;
  }

  // Set datetime based add date (+)
  DateTime _setAddDate(int? addDate) {
    DateTime addedDate = DateTime.now().add(Duration(days: addDate!));
    return addedDate;
  }

  // Set value for radio button select
  void _setFromRadioFilterDateRange(
    JNMSelectDateRangeBottomSheetOption value,
  ) {
    DateTimeRange? dateRange;
    JNMSelectDateRangeBottomSheetOption? selectedOptions;
    if (value == JNMSelectDateRangeBottomSheetOption.allTime) {
      dateRange = _setDateTimeRange(DateTime(1970, 01, 01), dateTimeNow);
      selectedOptions = JNMSelectDateRangeBottomSheetOption.allTime;
    } else if (value == JNMSelectDateRangeBottomSheetOption.today) {
      dateRange = _setDateTimeRange(_setForToday(), dateTimeNow);
      selectedOptions = JNMSelectDateRangeBottomSheetOption.today;
    } else if (value == JNMSelectDateRangeBottomSheetOption.oneWeek) {
      dateRange = _setDateTimeRange(_setSubTractDate(7), dateTimeNow);
      selectedOptions = JNMSelectDateRangeBottomSheetOption.oneWeek;
    } else if (value == JNMSelectDateRangeBottomSheetOption.oneMonth) {
      dateRange = _setDateTimeRange(_setSubTractDate(30), dateTimeNow);
      selectedOptions = JNMSelectDateRangeBottomSheetOption.oneMonth;
    } else if (value == JNMSelectDateRangeBottomSheetOption.threeMonths) {
      dateRange = _setDateTimeRange(_setSubTractDate(90), dateTimeNow);
      selectedOptions = JNMSelectDateRangeBottomSheetOption.threeMonths;
    } else if (value == JNMSelectDateRangeBottomSheetOption.fourMonths) {
      dateRange = _setDateTimeRange(_setSubTractDate(120), dateTimeNow);
      selectedOptions = JNMSelectDateRangeBottomSheetOption.fourMonths;
    } else if (value == JNMSelectDateRangeBottomSheetOption.oneYear) {
      dateRange = _setDateTimeRange(_setSubTractDate(360), dateTimeNow);
      selectedOptions = JNMSelectDateRangeBottomSheetOption.oneYear;
    } else if (value == JNMSelectDateRangeBottomSheetOption.lastYear) {
      dateRange = _setDateTimeRange(
        DateTime(dateTimeNow.year - 1),
        DateTime(dateTimeNow.year - 1, 12, 31),
      );
      selectedOptions = JNMSelectDateRangeBottomSheetOption.lastYear;
    } else if (value == JNMSelectDateRangeBottomSheetOption.selectYear) {
      if (widget.selectedYear != null) {
        dateRange = _setDateTimeRange(
          DateTime(widget.selectedYear!),
          DateTime(widget.selectedYear!, 12, 31),
        );
      }
      selectedOptions = JNMSelectDateRangeBottomSheetOption.selectYear;
    } else if (value ==
        JNMSelectDateRangeBottomSheetOption.selectDateRange) {
      if (widget.selectedDateRange != null) {
        dateRange = widget.selectedDateRange!;
      }
      selectedOptions = JNMSelectDateRangeBottomSheetOption.selectDateRange;
    }

    setState(() {
      dateRanges = dateRange;
      _selectedOption = selectedOptions;
    });
  }

  // Set value for dropdown select years
  Widget _buildChooseAnotherYears(
    BuildContext context,
    int minYear,
    int maxYear,
  ) {
    List<String> getYearsList = [];
    DateTime startYears = DateTime(dateTimeNow.year - minYear);
    DateTime endYears = DateTime(dateTimeNow.year + maxYear);
    for (int i = startYears.year; i <= endYears.year; i++) {
      getYearsList.add(i.toString());
    }

    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 12.0),
      child: JNMDropdownInputField(
        hintText: 'Pilih tahun',
        initialValue:
            widget.selectedYear != null ? widget.selectedYear.toString() : '',
        options: getYearsList
            .map(
              (e) => JNMDropdownInputFieldOption(
                value: e,
                title: e,
              ),
            )
            .toList(),
        onChanged: (String? result) {
          setState(() {
            dateRanges = _setDateTimeRange(
              DateTime(int.parse(result!), 01, 01),
              DateTime(int.parse(result), 12, 31),
            );
          });
        },
      ),
    );
  }
}
