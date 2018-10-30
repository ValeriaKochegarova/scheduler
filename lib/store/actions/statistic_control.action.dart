class SetMonthPeriod {}

class SetYearPeriod {}

class GetStartOfStatisticPeriodPending {}

class GetStartOfStatisticPeriodSuccess {
  final DateTime date;
  GetStartOfStatisticPeriodSuccess(this.date);
}

class GetStartOfStatisticPeriodError {
  final dynamic error;
  GetStartOfStatisticPeriodError(this.error);
}
