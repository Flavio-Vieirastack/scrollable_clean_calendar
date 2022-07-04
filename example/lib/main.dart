import 'package:flutter/material.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrollable Clean Calendar',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xFF3F51B5),
          secondary: Color(0xFFD32F2F),
          surface: Color(0xFFDEE2E6),
          background: Color(0xFFF8F9FA),
          error: Color(0xFF96031A),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      home: const Calendar(),
    );
  }
}

class Calendar extends StatefulWidget {
  const Calendar({ key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final calendarController = CleanCalendarController(
    minDate: DateTime(2000),
    maxDate: DateTime(2100),
    onRangeSelected: (firstDate, secondDate) {},
    onDayTapped: (date) {},
    onPreviousMinDateTapped: (date) {},
    onAfterMaxDateTapped: (date) {},
    weekdayStart: DateTime.monday,
  );

  int _month = 0;

  @override
  void initState() {
    final currentDate = DateTime.now();
    _month = calendarController.getMonths.indexWhere(
      (element) =>
          element.year == currentDate.year &&
          element.month == currentDate.month,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrollable Clean Calendar'),
        actions: [
          IconButton(
            onPressed: calendarController.clearSelectedDates,
            icon: const Icon(Icons.clear),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (_month - 12 >= 0) {
                      _month -= 12;
                    } else {
                      _month = 0;
                    }

                    setState(() {});
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Expanded(
                  child: Text(
                    calendarController.getMonths[_month].year.toString(),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_month + 12 <=
                        calendarController.getMonths.length - 1) {
                      _month += 12;
                    } else {
                      _month = calendarController.getMonths.length - 1;
                    }
                    setState(() {});
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
            ScrollableCleanCalendar(
              calendarController: calendarController,
              layout: Layout.BEAUTY,
              monthBuilder: (_, month) {
                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (_month > 0) {
                          _month--;

                          setState(() {});
                        }
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    Expanded(
                      child: Text(month),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_month < calendarController.getMonths.length - 1) {
                          _month++;

                          setState(() {});
                        }
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                );
              },
              calendarCrossAxisSpacing: 4,
              currentMonth: _month,
            ),
          ],
        ),
      ),
    );
  }
}
