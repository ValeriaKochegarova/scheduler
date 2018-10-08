// import 'package:intl/intl.dart';
import 'package:scheduler_app/store/actions/calendar.action.dart';

dynamic calendarReducer(dynamic state, action) {
  if (action is SelectDate) {
    // String formatedDate = DateFormat('EEE, dd').format(action.date);
    return action.date.toString();
  }
  return state;
}
