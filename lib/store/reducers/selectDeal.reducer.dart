import 'package:scheduler_app/store/actions/deals.action.dart';

dynamic selectedDealReducer(state, action) {
  if (action is SelectDeal) {
    state = action.selectedDeal;
    print(state);
  }

  if (action is UnselectDeal) {
    state = null;
    print({'UNSELECT': state});
  }
  return state;
}
