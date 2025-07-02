


import '../../data/repositories/home_repository.dart';

class GetProductUseCase{
  HomeRepository repository;
  GetProductUseCase(this.repository);

  Future<void>call() async {
    return await repository.getProducts();
  }
}