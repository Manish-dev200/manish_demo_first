


import '../../data/repositories/dashboard_repository.dart';

class GetProductUseCase{
  DashboardRepository repository;
  GetProductUseCase(this.repository);

  Future<void>call() async {
    return await repository.getProducts();
  }
}