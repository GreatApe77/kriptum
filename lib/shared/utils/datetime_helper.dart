class DatetimeHelper {
  static const Map<int, String> _monthNumberToMonthName = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'Aug',
    9: 'Sept',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };

  static String getMonthTitle(int monthNumber){
    if(monthNumber<1 || monthNumber>12) throw Exception('Invalid monthNumber');
    return _monthNumberToMonthName[monthNumber]!;
  }
  static String getReadableDate(DateTime date){

    String month = getMonthTitle(date.month);

    int day = date.day;
    int hour = date.hour;
    int minute = date.minute;
    
    return '$month $day at $hour:$minute';
  }

  
}
