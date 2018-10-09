import 'package:scheduler_app/store/actions/calendar.action.dart';

dynamic calendarReducer(dynamic state, action) {
  if (action is SelectDate) {
    print(action.date);
    return action.date;
  }
  return state;
}
