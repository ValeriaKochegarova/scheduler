class UpdateDeal {
  final Map payload;
  UpdateDeal(this.payload);
}

class CreateDealPending {
  final deal;
  CreateDealPending(this.deal);
}

class CreateDealSuccess {
  final deal;
  CreateDealSuccess(this.deal);
}

class CreateDealError {
  final error;
  CreateDealError(this.error);
}

class GetDealsByDatePending {
  GetDealsByDatePending();
}

class GetDealsByDateSuccess {
  final deals;
  GetDealsByDateSuccess(this.deals);
}

class GetDealsByDateError {
  final error;
  GetDealsByDateError(this.error);
}