
import '../../data/datasources/product_detail_remote_data_source.dart';
import '../../data/repositories/product_detail_repository.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepository{
  ProductDetailRemoteDataSource remoteDataSource;
  ProductDetailRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> getProductDetail() async {
    return await remoteDataSource.getProductDetail();
  }

}