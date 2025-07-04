

import '../../data/repositories/product_detail_repository.dart';

class GetProductDetailUseCase{
  ProductDetailRepository repository;
  GetProductDetailUseCase(this.repository);

  Future<void>call() async {
    return await repository.getProductDetail();
  }
}