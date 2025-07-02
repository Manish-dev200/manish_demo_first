

import 'package:demo_first/features/cart/data/datasources/cart_remote_data_source.dart';

import '../../data/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository{
  CartRemoteDataSource remoteDataSource;
  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> getCartProducts() async {
    return await remoteDataSource.getCartProducts();
  }

}