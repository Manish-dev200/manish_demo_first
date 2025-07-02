

import '../../data/repositories/cart_repository.dart';

class GetCartProductUseCase{
  CartRepository repository;
  GetCartProductUseCase(this.repository);

  Future<void>call() async {
    return await repository.getCartProducts();
  }
}