import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DateShow extends StatefulWidget {
  const DateShow({super.key});

  @override
  State<DateShow> createState() => _DateShowState();
}

class _DateShowState extends State<DateShow> {

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // variables to store start and end date
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState(){
    super.initState();
    _selectedDay = _focusedDay;
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay){
    if(!isSameDay(_selectedDay, selectedDay)){
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay){
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      print(_rangeStart);
      print(_rangeEnd);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Center(
          child: Column(
            children: [
              TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2023, 3, 14),
                  lastDay: DateTime.now(),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: onDaySelected,
                rangeStartDay: _rangeStart,
                rangeSelectionMode: RangeSelectionMode.toggledOn,
                onRangeSelected: onRangeSelected,
                rangeEndDay: _rangeEnd,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false, // Hide the week view button
                  rightChevronVisible: false, // Hide the right arrow
                ),

                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false
                ),
                onFormatChanged: (format){
                    if(_calendarFormat != format){
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                },
                onPageChanged: (focusedDay){
                    _focusedDay = focusedDay;
                },
              ),


              const SizedBox(
                height: 30,
              ),

              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  // _showCalendarDialog(context);
                },
                  child: Text('press')),
            ],
          ),
        ),
      ),
    );
  }

  void _showCalendarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 372,
            padding: EdgeInsets.all(16),
            child: TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2023, 3, 14),
              lastDay: DateTime.now(),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: onDaySelected,
              rangeStartDay: _rangeStart,
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              onRangeSelected: onRangeSelected,
              rangeEndDay: _rangeEnd,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false, // Hide the week view button
                rightChevronVisible: false, // Hide the right arrow
              ),
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
              ),
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
            ),
          ),
        );
      },
    );
  }

}
