

import '../../data/repositories/checkout_repository.dart';

class GetCartProductUseCase{
  CheckoutRepository repository;
  GetCartProductUseCase(this.repository);

  Future<void>call() async {
    return await repository.getCartProducts();
  }
}