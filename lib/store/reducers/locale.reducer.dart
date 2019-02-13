import 'package:scheduler_app/store/actions/locale.action.dart';

dynamic setLocaleReducer(state, action) {
  if (action is SetLocale) {
   return state = action.lang;
  }
  return state;
}
