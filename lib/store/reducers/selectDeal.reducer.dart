import 'package:scheduler_app/store/actions/deals.action.dart';

dynamic selectedDealReducer(state, action) {
  if (action is SelectDeal) {
    state = action.selectedDeal;
  }

  if (action is UnselectDeal) {
    state = null;
  }
  return state;
}
