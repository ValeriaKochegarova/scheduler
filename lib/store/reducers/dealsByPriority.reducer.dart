import 'package:scheduler_app/store/actions/deals.action.dart';

dynamic dealsByPriorityReducer(state, action) {
  if (action is SetPriorityFilter) {
    state = action.priority;
  }
  if (action is UnsetPriorityDeal) {
    state = null;
  }
  return state;
}