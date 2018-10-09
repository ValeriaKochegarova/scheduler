// update deal
class UpdateDealPending {
  final Map payload;
  UpdateDealPending(this.payload);
}

class UpdateDealSuccess {
  final Map payload;
  UpdateDealSuccess(this.payload);
}

class UpdateDealError {
  final Map payload;
  UpdateDealError(this.payload);
}

// create deal
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

// get deals
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

// select deal
class SelectDeal {
  final selectedDeal;
  SelectDeal(this.selectedDeal);
}

class UnselectDeal {
}

// delete deal
class DeleteDealPending {
  final deal;
  DeleteDealPending(this.deal);
}

class DeleteDealSuccess {
  final deal;
  DeleteDealSuccess(this.deal);
}

class DeleteDealError {
  final error;
  DeleteDealError(this.error);
}