


import '../../data/datasources/checkout_remote_data_source.dart';
import '../../data/repositories/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository{
  CheckoutRemoteDataSource remoteDataSource;
  CheckoutRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> getCartProducts() async {
    return await remoteDataSource.getCartProducts();
  }

}