class UpdateDeal {
  final Map payload;
  UpdateDeal(this.payload);
}

class GetDealsFromDb {
  final dynamic deals;
  GetDealsFromDb(this.deals);
}

class GetDealsPending {
  GetDealsPending();
}

class GetDealsSuccess {
  final deals;
  GetDealsSuccess(this.deals);
}

class GetDealsError {
  final error;
  GetDealsError(this.error);
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