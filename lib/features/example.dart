import 'package:flutter/material.dart';

class ExampleDate extends StatefulWidget {
  const ExampleDate({super.key});

  @override
  State<ExampleDate> createState() => _ExampleDateState();
}

class _ExampleDateState extends State<ExampleDate> {

  dynamic _fromDate;
  dynamic _toDate;

  // // Function to show date picker for 'From' date
  // Future<void> _selectFromDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _fromDate ?? DateTime.now(),
  //     firstDate: DateTime(2015, 8),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != _fromDate) {
  //     setState(() {
  //       _fromDate = picked;
  //     });
  //   }
  // }
  //
  // // Function to show date picker for 'To' date
  // Future<void> _selectToDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _toDate ?? DateTime.now(),
  //     firstDate: DateTime(2015, 8),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != _toDate) {
  //     setState(() {
  //       _toDate = picked;
  //     });
  //   }
  // }

  dynamic _selectedFromDate;
  dynamic _selectedToDate;

  void _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
      initialDateRange: _selectedFromDate != null && _selectedToDate != null
          ? DateTimeRange(start: _selectedFromDate, end: _selectedToDate)
          : null,
    );

    if (picked != null) {
      setState(() {
        _selectedFromDate = picked.start;
        _selectedToDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => _selectDateRange(context),
          child: Text('Select Date Range'),
        ),
        SizedBox(height: 20),
        Text(
          _selectedFromDate != null && _selectedToDate != null
              ? 'From: ${_selectedFromDate.toString()} To: ${_selectedToDate.toString()}'
              : 'Date range not selected',
        ),
      ],
    );
    //   Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: <Widget>[
    //     TextButton(
    //       onPressed: () => _selectFromDate(context),
    //       child: Text(_fromDate == null ? 'Select From Date' : 'From: ${_fromDate!.toString().substring(0, 10)}'),
    //     ),
    //     SizedBox(height: 20),
    //     TextButton(
    //       onPressed: () => _selectToDate(context),
    //       child: Text(_toDate == null ? 'Select To Date' : 'To: ${_toDate!.toString().substring(0, 10)}'),
    //     ),
    //     SizedBox(height: 20),
    //     Text(
    //       _fromDate != null && _toDate != null
    //           ? 'Selected date range: ${_fromDate!.toString().substring(0, 10)} - ${_toDate!.toString().substring(0, 10)}'
    //           : '',
    //       style: TextStyle(fontSize: 18),
    //     ),
    //   ],
    // );
  }
}
