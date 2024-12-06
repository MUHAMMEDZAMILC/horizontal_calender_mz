library horizontal_calender_mz;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'apptext.dart';

class HorizontalCalenderMZ extends StatefulWidget {
  HorizontalCalenderMZ(
      {super.key,
      required this.selectedDate,
      this.header,
      this.selectedbgcolor,
      this.unselectedbgcolor,
      this.calendericon,
      this.seldaynamecolor,
      this.seldaynumbercolor,
      this.unseldaynamecolor,
      this.unseldaynumbercolor,this.selectedbordercolor,this.unselectedbordercolor,this.footer= false,this.footertext,this.footerstyle,this.startyear,this.endyear,this.onDateSelected});
  Widget? header, calendericon;
  bool? footer = false;
  int? startyear,endyear;
  ValueChanged<DateTime>? onDateSelected;
  String? footertext;
  TextStyle? footerstyle;
  Color? selectedbgcolor,
      unselectedbgcolor,
      seldaynamecolor,
      unseldaynamecolor,
      seldaynumbercolor,
      unseldaynumbercolor,selectedbordercolor,unselectedbordercolor;
      ValueNotifier<DateTime?> selectedDate;
  @override
  State<HorizontalCalenderMZ> createState() => _HorizontalCalenderMZState();
}

class _HorizontalCalenderMZState extends State<HorizontalCalenderMZ> {
  final ScrollController _scrollController = ScrollController();
  DateTime localToday = DateTime.now();
  late DateTime firstDayOfMonth;
  late DateTime lastDayOfMonth;
  var weekDayFormat = DateFormat('EEE');
  @override
  void initState() {
    _updateMonthBounds(DateTime.now());
    super.initState();
  }

  void _updateMonthBounds(DateTime date) {
    firstDayOfMonth = DateTime(date.year, date.month, 1);
    lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    setState(() {});
  }

  String getMonthName(int month) {
    // Check if month is valid
    if (month < 1 || month > 12) {
      return 'Invalid month';
    }
    // Create a DateTime object with the given month
    DateTime date = DateTime(2024, month); // Year is arbitrary
    // Use DateFormat to get the month name
    return DateFormat('MMMM').format(date);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      // barrierColor: ColorResources.WHITE,
      context: context,
      initialDate:widget. selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(widget.startyear??2000),
      lastDate: DateTime(widget.endyear??2100),
    );

    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.selectedDate.value = picked;
      });
    }
      if (widget.onDateSelected != null) {
      widget.onDateSelected!(picked!);
    }
    _updateMonthBounds(widget.selectedDate.value ?? DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: widget.header ?? const SizedBox()),
                IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: widget.calendericon ??
                        const Icon(
                          CupertinoIcons.calendar,
                          color: Colors.black,
                          size: 20,
                        ))
              ],
            ),
            if (widget.header != null)
              const SizedBox(
                height: 8,
              ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 75,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                          height: 75,
                          child: ListView.builder(
                              controller: _scrollController,
                              itemCount: lastDayOfMonth
                                  .day, // maxSaleDate.difference(minSaleDate).inDays,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, i) {
                                DateTime date =
                                    firstDayOfMonth.add(Duration(days: i));
                                String weekdaydata = weekDayFormat.format(date);
                                return Padding(
                                  padding: const EdgeInsets.only(right: 6.0),
                                  child: SizedBox(
                                    width: 45,
                                    child: InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      onTap: () {
                                        // if (UserAccessFunctions.canSeeCashFlow()) {
                                        HapticFeedback.selectionClick();
                                        (widget.selectedDate.value?.year ==
                                                    date.year &&
                                                widget.selectedDate.value?.month ==
                                                    date.month &&
                                                widget.selectedDate.value?.day ==
                                                    date.day)
                                            ? null
                                            : setState(() {
                                                widget.selectedDate.value = date;
                                              });
                                        DateTime currentDateTime =
                                            widget.selectedDate.value ??
                                                DateTime.now();
                                        DateTime dateOnly = DateTime(
                                            currentDateTime.year,
                                            currentDateTime.month,
                                            currentDateTime.day);
                                       widget. selectedDate.value = dateOnly;
                                       if (widget.onDateSelected != null) {
      widget.onDateSelected!(dateOnly);
    }
                                        // }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: (widget.selectedDate.value?.year == date.year &&
                                                        widget.selectedDate.value?.month ==
                                                            date.month &&
                                                        widget.selectedDate.value?.day ==
                                                            date.day)
                                                    ?widget.selectedbordercolor?? Colors.transparent
                                                    : widget.unselectedbordercolor?? const Color(0xFF9ca4a7)
                                                        .withOpacity(0.2)),
                                            color: (widget.selectedDate.value?.year ==
                                                        date.year &&
                                                    widget.selectedDate.value?.month ==
                                                        date.month &&
                                                    widget.selectedDate.value?.day ==
                                                        date.day)
                                                ? widget.selectedbgcolor ??
                                                    const Color(0xFF1FA7FF)
                                                : widget.unselectedbgcolor ?? Colors.white),
                                        height: 70,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0, horizontal: 4.0),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const SizedBox(
                                                  height: 1,
                                                ),
                                                AppText(
                                                  text: weekdaydata,
                                                  color: (widget.selectedDate.value
                                                                  ?.year ==
                                                              date.year &&
                                                          widget.selectedDate.value
                                                                  ?.month ==
                                                              date.month &&
                                                          widget.selectedDate.value
                                                                  ?.day ==
                                                              date.day)
                                                      ? widget.seldaynamecolor ??
                                                          Colors.white
                                                      : widget.unseldaynamecolor ??
                                                          Colors.grey,
                                                  size: 12,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: (widget.selectedDate
                                                                      .value
                                                                      ?.year ==
                                                                  date.year &&
                                                              widget.selectedDate
                                                                      .value
                                                                      ?.month ==
                                                                  date.month &&
                                                              widget.selectedDate
                                                                      .value
                                                                      ?.day ==
                                                                  date.day)
                                                          ? Colors.white
                                                          : Colors.transparent),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                      child: AppText(
                                                        text:
                                                            date.day.toString(),
                                                        color: (widget.selectedDate
                                                                        .value
                                                                        ?.year ==
                                                                    date.year &&
                                                                widget.selectedDate
                                                                        .value
                                                                        ?.month ==
                                                                    date
                                                                        .month &&
                                                                widget.selectedDate
                                                                        .value
                                                                        ?.day ==
                                                                    date.day)
                                                            ? widget.seldaynumbercolor ??
                                                                const Color(
                                                                    0xFF1FA7FF)
                                                            : widget.unseldaynumbercolor ??
                                                                Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ),
                                    //  salesCalendarButton(false, weekdaydata, date)
                                  ),
                                );
                              }))),
                    ),
                  ),
                ],
              ),
            ),
            if(widget.footer==true)
            const SizedBox(
              height: 8,
            ),
            if(widget.footer==true)
            (widget.selectedDate.value != null)
                ? widget.footerstyle!=null? Text('${widget.footertext} ${getMonthName(widget.selectedDate.value!.month)} ${widget.selectedDate.value?.day.toString()}',style: widget.footerstyle,): AppText(
                    text:
                        '${widget.footertext??''} ${getMonthName(widget.selectedDate.value!.month)} ${widget.selectedDate.value?.day.toString()}',
                    color: Colors.grey,
                    size: 12,
                    weight: FontWeight.w300,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
